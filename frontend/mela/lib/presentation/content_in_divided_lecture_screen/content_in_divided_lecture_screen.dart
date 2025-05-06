import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/params/history/section_progress_params.dart';
import 'package:mela/domain/usecase/history/update_section_progress_usecase.dart';
import 'package:mela/presentation/review/widgets/draggable_ai_button.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../di/service_locator.dart';

class ContentInDividedLectureScreen extends StatefulWidget {
  final DividedLecture currentDividedLecture;

  const ContentInDividedLectureScreen(
      {super.key, required this.currentDividedLecture});

  @override
  State<ContentInDividedLectureScreen> createState() =>
      _ContentInDividedLectureScreenState();
}

class _ContentInDividedLectureScreenState
    extends State<ContentInDividedLectureScreen> {
  OverlayEntry? _overlayEntry;
  late PdfViewerController _pdfViewerController;
  final _threadChatStore = getIt.get<ThreadChatStore>();
  int _totalPages = 0;

  final UpdateSectionProgressUsecase _updateUsecase =
      getIt<UpdateSectionProgressUsecase>();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    //call to update
    final sectionToUpdate = widget.currentDividedLecture;
    final params = SectionProgressParams(
        lectureId: sectionToUpdate.lectureId,
        ordinalNumber: sectionToUpdate.ordinalNumber,
        completedAt: DateTime.now());
    _updateUsecase.call(params: params);
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
    print("===============ContentInDividedLectureScreen");
    print(widget.currentDividedLecture.urlContentInDividedLecture);
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
            print("------------->Back button pressed");
            print(Navigator.of(context).widget.pages);

            Navigator.of(context).pop();
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
                child: SfPdfViewer.network(
                  onTextSelectionChanged:
                      (PdfTextSelectionChangedDetails details) {
                    if (details.selectedText == null && _overlayEntry != null) {
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
                ),
              ),
            ),
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
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, color: Colors.black),
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
                  icon: const Icon(Icons.chat, color: Colors.black),
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
    _threadChatStore.setConversation(Conversation(
        conversationId: "",
        messages: [],
        hasMore: false,
        levelConversation: LevelConversation.UNIDENTIFIED,
        dateConversation: DateTime.now(),
        nameConversation: ""));
    //Push chat screen with transition
    Navigator.of(context).pushNamed(Routes.threadChatScreen);
    _threadChatStore.sendChatMessage(selectedText, []);
  }
}
