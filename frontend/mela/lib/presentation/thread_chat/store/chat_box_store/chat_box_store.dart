import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/domain/entity/image_origin/image_origin.dart';
import 'package:mela/utils/image_picker_helper/image_picker_helper.dart';
import 'package:mobx/mobx.dart';

part 'chat_box_store.g.dart';

class ChatBoxStore = _ChatBoxStore with _$ChatBoxStore;

abstract class _ChatBoxStore with Store {
  _ChatBoxStore() {}
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  @observable
  bool showSendIcon = false;

  @observable
  bool showCameraIcon = true;

  @observable
  ObservableList<File> images = ObservableList<File>.of([]);

  @action
  void setShowSendIcon(bool value) {
    showSendIcon = value;
  }

  @action
  void setShowCameraIcon(bool value) {
    showCameraIcon = value;
  }

  @action
    Future<void> pickImage(ImageSource imageSource) async {
    XFile? image = await _imagePickerHelper.pickImageFromGalleryOrCamera(
        source: imageSource);

    if (image != null) {
      // File imageFile = File(image.path);
      // _imagesNotifier.value = [imageFile];
      CroppedFile? croppedFile = await _imagePickerHelper.cropImage(image);
      if (croppedFile == null) return;
      File imageFile = File(croppedFile.path);
      images.add(imageFile);
      showSendIcon = true;
      // _imagesNotifier.value = [imageFile];
      // _chatBoxStore.setShowSendIcon(true);
    }
  }
}
  // constructor:--------------------------------