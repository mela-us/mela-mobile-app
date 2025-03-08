import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/support_item.dart';
import 'package:mela/utils/image_picker_helper/image_picker_helper.dart';

class ChatBox extends StatefulWidget {
  ChatBox({super.key});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _controller = TextEditingController();
  final _chatBoxStore = getIt.get<ChatBoxStore>();
  final _threadChatStore = getIt.get<ThreadChatStore>();
  final FocusNode _focusNode = FocusNode();
  ValueNotifier<List<File>> _imagesNotifier = ValueNotifier<List<File>>([]);
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  @override
  void initState() {
    super.initState();
    _controller.addListener(onTextChanged);
    _focusNode.addListener(() {
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _controller.removeListener(onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  //Event to display/hide the accessibility icons
  void onTextChanged() {
    if (_controller.text.isNotEmpty && _threadChatStore.isLoading == false) {
      _chatBoxStore.setShowSendIcon(true);
    } else {
      _chatBoxStore.setShowSendIcon(false);
    }
  }

  void _removeImage(File image) {
    _imagesNotifier.value.remove(image);

    //Must update the value to notify the listeners
    _imagesNotifier.value = _imagesNotifier.value.toList();
  }

  Future<void> pickImage(ImageSource imageSource) async {
    XFile? image = await _imagePickerHelper.pickImageFromGalleryOrCamera(
        source: imageSource);
    if (image != null) {
      CroppedFile? croppedFile = await _imagePickerHelper.cropImage(image);
      if (croppedFile == null) return;
      File imageFile = File(croppedFile.path);
      _imagesNotifier.value = [imageFile];
    }
  }

  Future<void> pickMultiImage() async {
    List<XFile> images = await _imagePickerHelper.pickMultipleImages();
    if (images.isNotEmpty) {
      List<File> imageFiles = images.map((image) => File(image.path)).toList();
      _imagesNotifier.value = imageFiles;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Colors.white54,
            border: _focusNode.hasFocus
                ? Border.all(color: Colors.red, width: 1)
                : Border.all(color: Colors.green, width: 1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Images when choose from library
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ValueListenableBuilder(
                    valueListenable: _imagesNotifier,
                    builder: (context, images, child) {
                      return images.isEmpty
                          ? const SizedBox()
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...images.map((image) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Stack(
                                        children: [
                                          // Image container
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                focusColor: Colors.amber,
                                                onTap: () {
                                                  _removeImage(image);
                                                },
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
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
                            );
                    }),
              ),

              //TextField
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _controller,
                        maxLines: 3,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Observer(
                    builder: (_) {
                      return _chatBoxStore.showSendIcon
                          ? IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () async {
                                String message = _controller.text.trim();
                                _controller.clear();
                                _chatBoxStore.setShowSendIcon(false);

                                // Hide keyboard
                                if (_focusNode.hasFocus) {
                                  _focusNode.unfocus();
                                }

                                await _threadChatStore.sendChatMessage(message);

                                //Using for while loading response user enter new message availale
                                if (_controller.text.isNotEmpty)
                                  _chatBoxStore.setShowSendIcon(true);
                              },
                            )
                          : const SizedBox();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),

              //Support Icons
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: SupportItem(
                            icon: Icons.functions,
                            textSupport: "Công thức",
                            onTap: () => pickMultiImage())),
                    Expanded(
                        child: SupportItem(
                            icon: Icons.image,
                            textSupport: "Hình ảnh",
                            onTap: () => pickImage(ImageSource.gallery))),
                    Expanded(
                        child: SupportItem(
                            icon: Icons.camera_alt,
                            textSupport: "Camera",
                            onTap: () => pickImage(ImageSource.camera))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
