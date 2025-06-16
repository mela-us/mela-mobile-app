import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/presentation/thread_chat_learning/store/chat_box_learning_store/chat_box_learning_store.dart';
import 'package:mobx/mobx.dart';

import '../store/thread_chat_learning_store/thread_chat_learning_store.dart';

class ChatBoxLearning extends StatefulWidget {
  const ChatBoxLearning({super.key});

  @override
  _ChatBoxLearningState createState() => _ChatBoxLearningState();
}

class _ChatBoxLearningState extends State<ChatBoxLearning> {
  final TextEditingController _controller = TextEditingController();
  // late final _controllerMath = MathFieldEditingController();
  // bool _isMathMode = false;
  final _chatBoxLearningStore = getIt.get<ChatBoxLearningStore>();
  final _threadChatLearningStore = getIt.get<ThreadChatLearningStore>();
  final FocusNode _focusNode = FocusNode();
  late ReactionDisposer disposerIsDisplayCamera;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatBoxLearningStore.setShowSendIcon(false);
      _chatBoxLearningStore.clearImages();
    });
    _controller.addListener(onTextChanged);
    _focusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });

    disposerIsDisplayCamera = reaction<Conversation>(
      (_) => _threadChatLearningStore.currentConversation,
      (value) {
        // if (value.levelConversation == LevelConversation.PROBLEM_IDENTIFIED) {
        //   print("Current Conversation thay doi thanh PROBLEM_IDENTIFIED");
        //   _chatBoxLearningStore.setShowCameraIcon(false);
        // } else if (value.levelConversation == LevelConversation.UNIDENTIFIED) {
        //   print("Current Conversation thay doi thanh UNIDENTIFIED");
        //   _chatBoxLearningStore.setShowCameraIcon(true);
        // } else {
        //   //For open from history
        //   print("Current Conversation Level -----> ${value.levelConversation}");
        //   _chatBoxLearningStore.setShowCameraIcon(false);
        // }
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
    _chatBoxLearningStore.setText(_controller.text);
    if ((_controller.text.isNotEmpty ||
            _chatBoxLearningStore.images.isNotEmpty) &&
        _threadChatLearningStore.isLoading == false) {
      _chatBoxLearningStore.setShowSendIcon(true);
    } else {
      _chatBoxLearningStore.setShowSendIcon(false);
    }
  }

  //Remove Image in the list
  // void _removeImage(File image) {
  //   _chatBoxLearningStore.removeImage(image);
  //   if (_chatBoxLearningStore.images.isEmpty && _controller.text.isEmpty) {
  //     _chatBoxLearningStore.setShowSendIcon(false);
  //   }
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {});
  // }

  void _showImagePickerOptions() {
    if (_threadChatLearningStore.isLoading) {
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
                _chatBoxLearningStore.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Chọn ảnh từ thư viện"),
              onTap: () {
                Navigator.pop(context);
                _chatBoxLearningStore.pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

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
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
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
        child: _chatBoxLearningStore.images.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._chatBoxLearningStore.images.map((image) {
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
                                    _chatBoxLearningStore.removeImage(image);
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
      //     "==================> _buildTextField: showSendIcon ${_chatBoxLearningStore.showSendIcon} showCameraIcon ${_chatBoxLearningStore.showCameraIcon}");
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _chatBoxLearningStore.showCameraIcon
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
                          hintText: "Đặt câu hỏi cho Mela về bài tập này nhé",
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
                        placeholder: "Đặt câu hỏi cho Mela về bài tập này nhé",
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
          _chatBoxLearningStore.showSendIcon
              ? GestureDetector(
                  onTap: () async {
                    if (_threadChatLearningStore.tokenChat == 0) {
                      showBottomEmptyToken();
                      return;
                    }
                    String message = _controller.text.trim();
                    _controller.clear();
                    _chatBoxLearningStore.setShowSendIcon(false);

                    // Hide keyboard
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                    }

                    List<File> images = _chatBoxLearningStore.images.toList();
                    _chatBoxLearningStore.clearImages();
                    await _threadChatLearningStore.sendChatMessage(
                        message, images);

                    //Using for while loading response user enter new message availale
                    if (_controller.text.isNotEmpty ||
                        _chatBoxLearningStore.images.isNotEmpty) {
                      _chatBoxLearningStore.setShowSendIcon(true);
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
}
