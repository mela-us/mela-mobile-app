import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:math_keyboard/math_keyboard.dart';
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
  late final _controllerMath = MathFieldEditingController();
  bool _isMathMode = false;
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

  //-----------------------Function
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

  void _showImagePickerOptions() {
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
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Chọn ảnh từ thư viện"),
              onTap: () {
                Navigator.pop(context);
                pickMultiImage();
              },
            ),
            // if (_image != null || !defaultImage)
            //   ListTile(
            //     leading: const Icon(Icons.delete, color: Colors.red),
            //     title: const Text("Xóa ảnh đại diện", style: TextStyle(color: Colors.red)),
            //     onTap: () {
            //       Navigator.pop(context);
            //       _removeImage();
            //     },
            //   ),
          ],
        );
      },
    );
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
              _buildListImagesIsSeclected(),

              //TextField
              _buildTextField(),
              const SizedBox(height: 5),

              //Support Icons
              _buildSupportIcons(),
            ],
          ),
        ),
      ),
    );
  }

  //-------------------------------Widget---------------
  Widget _buildListImagesIsSeclected() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                        _removeImage(image);
                                      },
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50),
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
    );
  }

  Widget _buildTextField() {
    return Row(
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

                      List<File> images = _imagesNotifier.value.toList();
                      _imagesNotifier.value = [];
                      await _threadChatStore.sendChatMessage(message, images);

                      //Using for while loading response user enter new message availale
                      if (_controller.text.isNotEmpty)
                        _chatBoxStore.setShowSendIcon(true);
                    },
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildSupportIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: SupportItem(
                  icon: Icons.functions,
                  textSupport: "Công thức",
                  onTap: () => pickImage(ImageSource.gallery))),
          // Expanded(
          //     child: SupportItem(
          //         icon: Icons.image,
          //         textSupport: "Hình ảnh",
          //         onTap: () => pickImage(ImageSource.gallery))),
          Expanded(
              child: SupportItem(
                  icon: Icons.camera_alt,
                  textSupport: "Camera",
                  onTap: _showImagePickerOptions)),
        ],
      ),
    );
  }

  // Widget _buildTextField() {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       Expanded(
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 12),
  //           child: Column(
  //             children: [
  //               _isMathMode
  //                   ? MathField(
  //                       controller: _controllerMath,
  //                       onSubmitted: (value) {
  //                         // Insert math expression at current cursor position
  //                         final cursorPos = _controller.selection.baseOffset;
  //                         final text = _controller.text;
  //                         final newText = text.substring(0, cursorPos) +
  //                             value +
  //                             text.substring(cursorPos);
  //                         _controller.text = newText;
  //                         setState(() => _isMathMode = false);
  //                       },
  //                       decoration: InputDecoration(
  //                         hintText: "Enter math expression",
  //                         suffixIcon: IconButton(
  //                           icon: Icon(Icons.keyboard_return),
  //                           onPressed: () =>
  //                               setState(() => _isMathMode = false),
  //                         ),
  //                       ),
  //                     )
  //                   : TextField(
  //                       controller: _controller,
  //                       maxLines: 3,
  //                       minLines: 1,
  //                       decoration: InputDecoration(
  //                         hintText: "Type a message",
  //                         border: InputBorder.none,
  //                         suffixIcon: IconButton(
  //                           icon: Icon(Icons.functions),
  //                           onPressed: () => setState(() => _isMathMode = true),
  //                         ),
  //                       ),
  //                     ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Observer(
  //         builder: (_) {
  //           return _chatBoxStore.showSendIcon
  //               ? IconButton(
  //                   icon: const Icon(Icons.send),
  //                   onPressed: () => _handleSend(),
  //                 )
  //               : const SizedBox();
  //         },
  //       ),
  //     ],
  //   );
  // }

  // void _handleSend() async {
  //   final message = _controller.text.trim();
  //   _controller.clear();
  //   _controllerMath.clear();
  //   _chatBoxStore.setShowSendIcon(false);

  //   if (_focusNode.hasFocus) {
  //     _focusNode.unfocus();
  //   }

  //   final images = _imagesNotifier.value.toList();
  //   _imagesNotifier.value = [];

  //   await _threadChatStore.sendChatMessage(message, images);

  //   if (_controller.text.isNotEmpty) {
  //     _chatBoxStore.setShowSendIcon(true);
  //   }
  // }
}
