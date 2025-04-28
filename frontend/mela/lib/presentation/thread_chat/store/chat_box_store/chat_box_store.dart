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

  //Selected/Remove image from button submission
  @observable
  bool isSelectedImageFromSubmission = false;

  @observable
  bool showSendIcon = false;

  @observable
  bool showCameraIcon = true;

  @observable
  ObservableList<File> images = ObservableList<File>.of([]);

  @observable
  String contentMessage = '';

  void setText(String value) {
    contentMessage = value;
  }

  @action
  void setShowSendIcon(bool value) {
    showSendIcon = value;
  }

  @action
  void setShowCameraIcon(bool value) {
    print('setShowCameraIcon: $value');
    showCameraIcon = value;
  }

  @action
  void setIsSelectedImageFromSubmission(bool value) {
    isSelectedImageFromSubmission = value;
  }

  @action
  Future<bool> pickImage(ImageSource imageSource) async {
    XFile? image = await _imagePickerHelper.pickImageFromGalleryOrCamera(
        source: imageSource);

    if (image != null) {
      // File imageFile = File(image.path);
      // _imagesNotifier.value = [imageFile];
      CroppedFile? croppedFile = await _imagePickerHelper.cropImage(image);
      if (croppedFile == null) return false;
      File imageFileCrop = File(croppedFile.path);
      images.clear();
      images.add(imageFileCrop);
      showSendIcon = true;
      return true;
      // _imagesNotifier.value = [imageFile];
      // _chatBoxStore.setShowSendIcon(true);
    }
    return false;
  }

  @action
  //Remove Image in the list
  void removeImage(File image) {
    if (isSelectedImageFromSubmission) {
      isSelectedImageFromSubmission = false;
    }
    images.remove(image);

    if (images.isEmpty && contentMessage.isEmpty) {
      showSendIcon = false;
    }

    // //Must update the value to notify the listeners
    // _imagesNotifier.value = _imagesNotifier.value.toList();
  }

  @action
  Future<void> pickMultiImage() async {
    List<XFile> imagesFromPicker =
        await _imagePickerHelper.pickMultipleImages();
    if (imagesFromPicker.isNotEmpty) {
      if (imagesFromPicker.length == 1) {
        CroppedFile? croppedFile =
            await _imagePickerHelper.cropImage(imagesFromPicker.first);
        if (croppedFile == null) return;
        File imageFileCrop = File(croppedFile.path);
        images.clear();
        images.add(imageFileCrop);
        // _imagesNotifier.value = [imageFile];
        return;
      }
      List<File> imageFiles =
          imagesFromPicker.map((image) => File(image.path)).toList();
      images.clear();
      images.addAll(imageFiles);
    }
  }

  @action
  void clearImages() {
    images.clear();
  }
}
  // constructor:--------------------------------