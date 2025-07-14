import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
// import 'package:math_keyboard/math_keyboard.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:mobx/mobx.dart';

class ChatBox extends StatefulWidget {
  final bool isFirstChatScreen;
  ChatBox({super.key, this.isFirstChatScreen = false});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _controller = TextEditingController();
  // late final _controllerMath = MathFieldEditingController();
  // bool _isMathMode = false;
  final _chatBoxStore = getIt.get<ChatBoxStore>();
  final _threadChatStore = getIt.get<ThreadChatStore>();
  final FocusNode _focusNode = FocusNode();
  late ReactionDisposer disposerIsDisplayCamera;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatBoxStore.setShowSendIcon(false);
      _chatBoxStore.setIsSelectedImageFromSubmission(false);
      _chatBoxStore.clearImages();
    });
    _controller.addListener(onTextChanged);
    _focusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });

    disposerIsDisplayCamera = reaction<Conversation>(
      (_) => _threadChatStore.currentConversation,
      (value) {
        if (value.levelConversation == LevelConversation.PROBLEM_IDENTIFIED) {
          print("Current Conversation thay doi thanh PROBLEM_IDENTIFIED");
          _chatBoxStore.setShowCameraIcon(false);
        } else if (value.levelConversation == LevelConversation.UNIDENTIFIED) {
          print("Current Conversation thay doi thanh UNIDENTIFIED");
          _chatBoxStore.setShowCameraIcon(true);
        } else {
          //For open from history
          print("Current Conversation Level -----> ${value.levelConversation}");
          _chatBoxStore.setShowCameraIcon(false);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.removeListener(onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    disposerIsDisplayCamera();

    super.dispose();
  }

  //-----------------------Function
  //Event to display/hide the accessibility icons
  void onTextChanged() {
    _chatBoxStore.setText(_controller.text);
    if ((_controller.text.isNotEmpty || _chatBoxStore.images.isNotEmpty) &&
        _threadChatStore.isLoading == false) {
      _chatBoxStore.setShowSendIcon(true);
    } else {
      _chatBoxStore.setShowSendIcon(false);
    }
  }

  //Remove Image in the list
  // void _removeImage(File image) {
  //   _chatBoxStore.removeImage(image);
  //   if (_chatBoxStore.images.isEmpty && _controller.text.isEmpty) {
  //     _chatBoxStore.setShowSendIcon(false);
  //   }
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {});
  // }

  void _showImagePickerOptions() {
    if (_threadChatStore.isLoading) {
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Chụp ảnh mới"),
              onTap: () {
                Navigator.pop(context);
                _chatBoxStore.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Chọn ảnh từ thư viện"),
              onTap: () {
                Navigator.pop(context);
                _chatBoxStore.pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return ShowCaseWidget(builder: Builder(builder: (context) {
  //     return Text("ABC");
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (_) {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        }
      },
      child: Focus(
        focusNode: _focusNode,
        child: Container(
          margin: widget.isFirstChatScreen
              ? null
              : const EdgeInsets.fromLTRB(5, 0, 5, 5),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: _focusNode.hasFocus
                ? Border.all(
                    color: Theme.of(context).colorScheme.buttonYesBgOrText,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    width: 1.5)
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Images when choose from library
              _buildListImagesIsSeclected(),

              //TextField
              _buildTextField(),
              const SizedBox(height: 5),

              //Support Icons
              // _buildSupportIcons(),
            ],
          ),
        ),
      ),
    );
  }

  //-------------------------------Widget---------------
  Widget _buildListImagesIsSeclected() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: _chatBoxStore.images.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._chatBoxStore.images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Stack(
                          children: [
                            // Image container
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 0),
                                image: DecorationImage(
                                  image: FileImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Close button
                            Positioned(
                              top: 3,
                              right: 3,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  focusColor: Colors.amber,
                                  onTap: () {
                                    _chatBoxStore.removeImage(image);
                                  },
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
      );
    });
  }

  Widget _buildTextField() {
    return Observer(builder: (_) {
      // print(
      //     "==================> _buildTextField: showSendIcon ${_chatBoxStore.showSendIcon} showCameraIcon ${_chatBoxStore.showCameraIcon}");
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _chatBoxStore.showCameraIcon
              ? GestureDetector(
                  onTap: _showImagePickerOptions,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Icon(Icons.image,
                        color: Theme.of(context)
                            .colorScheme
                            .buttonYesBgOrText
                            .withOpacity(0.8),
                        size: 24),
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: Container(
                padding: const EdgeInsets.only(right: 4, left: 6),
                child: kIsWeb || Platform.isAndroid
                    ? TextField(
                        controller: _controller,
                        maxLines: 3,
                        minLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          // contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: "Hãy cho Mela biết thắc mắc của bạn",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      )
                    : CupertinoTextField(
                        controller: _controller,
                        maxLines: 3,
                        minLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        textAlignVertical: TextAlignVertical.bottom,
                        placeholder: "Hãy cho Mela biết thắc mắc của bạn",
                        placeholderStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.transparent),
                        ),
                        cursorColor: Theme.of(context).primaryColor,
                      )),
          ),
          _chatBoxStore.showSendIcon
              ? GestureDetector(
                  onTap: () async {
                    if (_threadChatStore.tokenChat == 0) {
                      showBottomEmptyToken();
                      return;
                    }
                    if (widget.isFirstChatScreen) {
                      _threadChatStore.setConversation(Conversation(
                          conversationId: "",
                          messages: [],
                          hasMore: false,
                          levelConversation: LevelConversation.UNIDENTIFIED,
                          dateConversation: DateTime.now(),
                          nameConversation: ""));
                      //Push chat screen with transition
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          settings: const RouteSettings(
                              name: Routes.threadChatScreen),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ThreadChatScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return ClipRect(
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                        ),
                      );
                      // Navigator.of(context).pushNamed(Routes.threadChatScreen);
                    }

                    String message = _controller.text.trim();
                    _controller.clear();
                    _chatBoxStore.setShowSendIcon(false);

                    // Hide keyboard
                    if (_focusNode.hasFocus) {
                      print("==================> Hide keyboard");
                      _focusNode.unfocus();
                    }

                    List<File> images = _chatBoxStore.images.toList();
                    _chatBoxStore.clearImages();
                    if (_chatBoxStore.isSelectedImageFromSubmission) {
                      await _threadChatStore.sendMessageSubmitReview(
                          message, images);
                      _chatBoxStore.setIsSelectedImageFromSubmission(false);
                    } else {
                      await _threadChatStore.sendChatMessage(message, images);
                    }

                    //Using for while loading response user enter new message availale
                    if (_controller.text.isNotEmpty ||
                        _chatBoxStore.images.isNotEmpty) {
                      _chatBoxStore.setShowSendIcon(true);
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: Icon(Icons.send,
                        color: Theme.of(context).colorScheme.buttonYesBgOrText,
                        size: 24),
                  ),
                )
              : const SizedBox(),
        ],
      );
    });
  }

  void showBottomEmptyToken() {
    showModalBottomSheet(
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
                      'Lượt hỏi Mela AI',
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
                      'Có vẻ như bạn đã hết lượt hỏi Mela AI. Vui lòng học bài tập hoặc đợi sang hôm sau để có thể hỏi nhé!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  // Buttons
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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
                              'Đóng',
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
  }
  // Widget _buildSupportIcons() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 6),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Row(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {},
  //                 child: Icon(
  //                   Icons.functions,
  //                   color: Theme.of(context)
  //                       .colorScheme
  //                       .buttonYesBgOrText
  //                       .withOpacity(0.8),
  //                   size: 24,
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               GestureDetector(
  //                 onTap: () => pickImage(ImageSource.camera),
  //                 child: Icon(Icons.camera_alt,
  //                     color: Theme.of(context)
  //                         .colorScheme
  //                         .buttonYesBgOrText
  //                         .withOpacity(0.8),
  //                     size: 24),
  //               ),
  //               const SizedBox(width: 10),
  //               GestureDetector(
  //                 onTap: () => pickMultiImage(),
  //                 child: Icon(Icons.image,
  //                     color: Theme.of(context)
  //                         .colorScheme
  //                         .buttonYesBgOrText
  //                         .withOpacity(0.8),
  //                     size: 24),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
