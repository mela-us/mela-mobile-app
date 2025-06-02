import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/widgets/showcase_custom.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/params/history/section_progress_params.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';
import 'package:mela/domain/usecase/history/update_section_progress_usecase.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/list_proposed_new_lecture/store/list_proposed_new_suggestion_store.dart';
import 'package:mela/presentation/review/widgets/draggable_ai_button.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
import 'package:mela/presentation/thread_chat_learning/store/thread_chat_learning_store/thread_chat_learning_store.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../constants/assets.dart';
import '../../di/service_locator.dart';
import '../divided_lectures_and_exercises_screen/store/exercise_store.dart';

class ContentInDividedLectureScreen extends StatefulWidget {
  final DividedLecture currentDividedLecture;
  final String?
      suggestionId; // Has suggestionId if go to from suggestion in home

  const ContentInDividedLectureScreen(
      {super.key, required this.currentDividedLecture, this.suggestionId});

  @override
  State<ContentInDividedLectureScreen> createState() =>
      _ContentInDividedLectureScreenState();
}

class _ContentInDividedLectureScreenState
    extends State<ContentInDividedLectureScreen> {
  OverlayEntry? _overlayEntry;
  late PdfViewerController _pdfViewerController;
  final _threadChatLearningStore = getIt.get<ThreadChatLearningStore>();
  int _totalPages = 0;
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final _sharedPrefsHelper = getIt.get<SharedPreferenceHelper>();
  BuildContext? showCaseContext;

  GlobalKey _pdfKey = GlobalKey();

  final UpdateSectionProgressUsecase _updateUsecase =
      getIt<UpdateSectionProgressUsecase>();
  final ListProposedNewSuggestionStore _listProposedNewSuggestionStore =
      getIt<ListProposedNewSuggestionStore>();

  final ReviseStore _reviseStore = getIt.get<ReviseStore>();
  final ExerciseStore _exerciseStore = getIt.get<ExerciseStore>();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Thêm delay 500ms trước khi gọi startShowCase
      Future.delayed(const Duration(milliseconds: 300), () async {
        final isFirstTimeGoToPdf = await _sharedPrefsHelper.isFirstTimeGoToPdf;
        if (mounted && showCaseContext != null && isFirstTimeGoToPdf) {
          ShowCaseWidget.of(showCaseContext!).startShowCase([_pdfKey]);
        }
      });
    });
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _showPageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedPage = _pdfViewerController.pageNumber;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('Đi đến trang',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Trang từ (1-$_totalPages)',
                  labelStyle: Theme.of(context).textTheme.subHeading.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    selectedPage = int.parse(value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Hủy',
                  style: Theme.of(context)
                      .textTheme
                      .subHeading
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
            ),
            GestureDetector(
              onTap: () {
                if (selectedPage >= 1 && selectedPage <= _totalPages) {
                  _pdfViewerController.jumpToPage(selectedPage);
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 34, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Đi',
                    style: Theme.of(context).textTheme.subHeading.copyWith(
                        color: Theme.of(context).colorScheme.onTertiary)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          widget.currentDividedLecture.dividedLectureName,
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // print("------------->Back button pressed");
            // print(Navigator.of(context).widget.pages);

            _reviseStore.setSelectedItem(null);

            Navigator.of(context).pop(false);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: IconButton(
              onPressed: _showPageSelectionDialog,
              icon: Icon(
                Icons.find_in_page,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: SfPdfViewerTheme(
                data: SfPdfViewerThemeData(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  progressBarColor: Theme.of(context).colorScheme.primary,
                ),
                child: ShowCaseWidget(onFinish: () {
                  _sharedPrefsHelper.saveIsFirstTimeGoToPdf(false);
                }, builder: (context) {
                  showCaseContext = context;
                  return ShowcaseCustom(
                    keyWidget: _pdfKey,
                    title: "Hoàn thành bài học",
                    description:
                        "Bạn hãy đọc đến trang cuối cùng để MELA xác nhận hoàn thành bài giảng này nhé!",
                    child: SfPdfViewer.network(
                      onTextSelectionChanged:
                          (PdfTextSelectionChangedDetails details) {
                        if (details.selectedText == null &&
                            _overlayEntry != null) {
                          _overlayEntry!.remove();
                          _overlayEntry = null;
                        } else if (details.selectedText != null &&
                            _overlayEntry == null) {
                          _showContextMenu(context, details);
                        }
                      },
                      pageSpacing: 4,
                      widget.currentDividedLecture.urlContentInDividedLecture,
                      controller: _pdfViewerController,
                      canShowScrollHead: false,
                      canShowTextSelectionMenu: false,
                      enableDoubleTapZooming: true,
                      onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                        _totalPages = details.document.pages.count;
                      },
                      onPageChanged: (PdfPageChangedDetails details) async {
                        _currentPage.value = details.newPageNumber;
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 2,
            right: 16,
            child: ValueListenableBuilder(
                valueListenable: _currentPage,
                builder: (context, value, child) {
                  if (_totalPages != 0 && value >= _totalPages - 3) {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () async {
                          if (_reviseStore.selectedItem != null) {
                            // If the user is revising, update the review
                            await _reviseStore.updateReview(UpdateReviewParam(
                                reviewId: _reviseStore.selectedItem!.reviewId,
                                itemId: _reviseStore.selectedItem!.itemId,
                                ordinalNumber:
                                    _reviseStore.selectedItem!.ordinalNumber,
                                itemType: _reviseStore.selectedItem!.type,
                                isDone: true));

                            _reviseStore.setSelectedItem(null);
                          }
                          //if go to from suggestion, update section progress
                          if (widget.suggestionId != null) {
                            await _listProposedNewSuggestionStore
                                .updateSuggestion(
                                    widget.suggestionId!,
                                    widget.currentDividedLecture.lectureId,
                                    widget.currentDividedLecture.ordinalNumber,
                                    true);
                          } else {
                            //call to update
                            final sectionToUpdate =
                                widget.currentDividedLecture;
                            final params = SectionProgressParams(
                                lectureId: sectionToUpdate.lectureId,
                                ordinalNumber: sectionToUpdate.ordinalNumber,
                                completedAt: DateTime.now());
                            _updateUsecase.call(params: params);
                          }

                          final result = await showDialogGoToExercise();
                          if (result == null) return;
                          if (mounted) {
                            if (result && widget.suggestionId != null) {
                              _exerciseStore.setCurrentLecture(Lecture(
                                lectureId: widget.currentDividedLecture
                                    .lectureId, //only parameter is important
                                levelId: widget.currentDividedLecture.levelId,
                                topicId: widget.currentDividedLecture.topicId,
                                lectureDescription: "",
                                ordinalNumber:
                                    widget.currentDividedLecture.ordinalNumber,
                                lectureName: widget
                                    .currentDividedLecture.dividedLectureName,
                                totalExercises: 0,
                                totalPassExercises: 0,
                              ));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DividedLecturesAndExercisesScreen()));
                            } else if (!result && widget.suggestionId != null) {
                              Navigator.of(context).pop(true);//true to update suggestion
                            } else {
                              Navigator.of(context).pop(result);
                            }
                          }
                        },
                        child: Center(
                          child: Text(
                            "Đã học xong",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Asap',
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
          ),
          DraggableAIButton(),
        ],
      ),
    );
  }

  void _showContextMenu(
    BuildContext context,
    PdfTextSelectionChangedDetails details,
  ) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 50,
        left: details.globalSelectedRegion!.center.dx - 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.copy,
                      color: Theme.of(context).colorScheme.tertiary),
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: details.selectedText!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                    _pdfViewerController.clearSelection();
                  },
                ),
                IconButton(
                  icon: Image.asset(
                    Assets.nav_chat,
                    width: 28,
                    height: 28,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onPressed: () {
                    // Call your "Ask Mela AI" function here
                    // Đảm bảo overlay được xóa
                    if (_overlayEntry != null) {
                      _overlayEntry?.remove();
                      _overlayEntry = null;
                    }
                    // Xóa lựa chọn văn bản
                    _pdfViewerController.clearSelection();
                    //Pop selected text
                    Navigator.of(context).pop();

                    //Pop Selected Text Overlay
                    _handleGoToChatFromSelection(
                        details.selectedText ?? "Hỏi demo");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
    overlayState.insert(_overlayEntry!);
  }

  Future<void> _handleGoToChatFromSelection(
    String selectedText,
  ) async {
    _threadChatLearningStore.setConversation(Conversation(
        conversationId: "",
        messages: [],
        hasMore: false,
        levelConversation: LevelConversation.UNIDENTIFIED,
        dateConversation: DateTime.now(),
        nameConversation: ""));
    //Push chat screen with transition
    Navigator.of(context).pushNamed(Routes.threadChatLearningScreen);
    _threadChatLearningStore.sendChatMessage(selectedText, []);
  }

  Future<bool?> showDialogGoToExercise() async {
    final result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Center(
          child: TapRegion(
            onTapOutside: (event) {
              Navigator.of(context).pop();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    width: double.infinity,
                    child: Text(
                      'Bắt Đầu Luyện Tập',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Text(
                      'Bạn có muốn luyện tập ngay với những lí thuyết vừa học không?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  // Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Thoát ngay',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'Tiếp tục',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );

    return result;
  }
}
