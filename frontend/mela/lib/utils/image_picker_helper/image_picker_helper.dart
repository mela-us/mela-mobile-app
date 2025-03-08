import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  late ImagePicker _imagePicker;
  ImagePickerHelper() {
    _imagePicker = ImagePicker();
  }

  Future<XFile?> pickImageFromGalleryOrCamera(
      {int imageQuality = 100,
      ImageSource source = ImageSource.gallery}) async {
    try {
      print("------->Picking image ABC");
      XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: imageQuality,
        requestFullMetadata: true,
      );
      print("------->Path of image: ${image?.path}");
      return image;
    } catch (e) {
      print("Error in pickImage: $e");
      return null;
    }
  }

  Future<List<XFile>> pickMultipleImages({int imageQuality = 100}) async {
    try {
      final List<XFile> pickedFiles =
          await _imagePicker.pickMultiImage(imageQuality: imageQuality);
      if (pickedFiles.isNotEmpty) {
        return pickedFiles;
      }
      return [];
    } catch (e) {
      print("Error picking images: $e");
      return [];
    }
  }

  Future<CroppedFile?> cropImage(XFile image) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            // aspectRatioPresets: [
            //   CropAspectRatioPreset.original,
            //   CropAspectRatioPreset.square,
            //   // CropAspectRatioPresetCustom(),
            // ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            // aspectRatioPresets: [
            //   CropAspectRatioPreset.original,
            //   CropAspectRatioPreset.square,
            //   // CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
            // ],
          ),
        ],
      );
      return croppedFile;
    } catch (e) {
      print("Error in cropImage: $e");
      return null;
    }
  }
}
