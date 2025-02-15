import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';
import 'package:mela/presentation/personal/widgets/delete_account_dialog.dart';
import '../../di/service_locator.dart';
import '../../themes/default/colors_standards.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/routes/routes.dart';
import 'edit_screens/edit_birthdate_screen.dart';
import 'edit_screens/edit_name_screen.dart';

class PersonalInfo extends StatefulWidget {
  final String name;
  final String email;
  final String dob;
  final String? imageUrl;

  const PersonalInfo({
    super.key,
    required this.name,
    required this.email,
    required this.dob,
    this.imageUrl,
  });

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  File? _image; //for uploaded image
  late ImageProvider _profileImage; //can be _image or can be passed from imageURL
  bool defaultImage = false; //flag for default avatar image
  final PersonalStore _personalStore = getIt<PersonalStore>();

  final ImagePicker _picker = ImagePicker(); //image picker

  @override
  void initState() {
    super.initState();
    _setProfileImage();
  }

  void _navigateToEditName() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditNameScreen(
          name: widget.name,
          email: widget.email,
          dob: widget.dob,
          imageUrl: widget.imageUrl,
        ),
      ),
    );
  }

  void _navigateToEditEmail() { //not yet available for email editing
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => EditEmailScreen(email: widget.email),
    //   ),
    // );
  }

  void _navigateToEditBirthdate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditBirthdateScreen(
          name: widget.name,
          email: widget.email,
          dob: widget.dob,
          imageUrl: widget.imageUrl,
        ),
      ),
    );
  }

  // Hàm hiển thị hộp thoại xác nhận xóa tài khoản
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountConfirmationDialog(
          onDelete: () async {
            try {
              final success = await _personalStore.deleteAccount();
              if (success) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginScreen, (route) => false
                );
              }
            } catch (e) {
              if (e is DioException) {
                if (e.response?.statusCode == 401) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginScreen, (route) => false
                  );
                }
              }
              print(e.toString());
            }
          },
          onCancel: () {
            Navigator.of(context).pop(); // Đóng hộp thoại
          },
        );
      },
    );
  }

  void _setProfileImage() {
    if (_image != null) {
      _profileImage = FileImage(_image!);
      defaultImage = false;
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty && !defaultImage) {
      _profileImage = NetworkImage(widget.imageUrl!);
      defaultImage = false;
    } else {
      _profileImage = const AssetImage('assets/icons/default_profile_pic.png');
      defaultImage = true;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _setProfileImage();
        //
      });
      await _personalStore.updateImage(File(pickedFile.path));
      await _personalStore.getUserInfo();
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      defaultImage = true;
      _setProfileImage();
    });
    //TODO: call delete image
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
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Chọn ảnh từ thư viện"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (_image != null || !defaultImage)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Xóa ảnh đại diện", style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _removeImage();
                },
              ),
          ],
        );
      },
    );
  }

  void _showImageUpdatingNotAvailable() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text("Chức năng này hiện không khả dụng cho đến phiên bản sau!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
        backgroundColor: ColorsStandards.AppBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 570.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 310.0,
                  padding: const EdgeInsets.only(top: 70.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _navigateToEditName,
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Tên người dùng",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .content
                                      .copyWith(color: Theme.of(context).colorScheme.primary),
                                ),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToEditEmail,
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Email",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .content
                                      .copyWith(color: Theme.of(context).colorScheme.primary),
                                ),
                                //const SizedBox(width: 8.0),
                                //const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToEditBirthdate,
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Ngày sinh",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  widget.dob,
                                  style: Theme.of(context)
                                      .textTheme
                                      .content
                                      .copyWith(color: Theme.of(context).colorScheme.primary),
                                ),
                                const SizedBox(width: 8.0),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _showDeleteAccountDialog, // Gọi hàm hiển thị hộp thoại
                        child: Observer(
                          builder: (_) => ListTile(
                            title: Text(
                              "Xóa tài khoản",
                              style: Theme.of(context)
                                  .textTheme
                                  .subHeading
                                  .copyWith(color: Colors.redAccent),
                            ),
                            trailing: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8.0),
                                Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: _profileImage,
                          radius: 50.0,
                        ),
                        const SizedBox(height: 5.0),
                        Observer(builder: (_) => const Text("")),
                      ],
                    ),
                    Positioned(
                      bottom: 15,
                      right: -3,
                      child: IconButton(
                        icon: Image.asset(
                          "assets/icons/upload_profile_pic.png",
                          width: 30,
                          height: 30,
                        ),
                        onPressed: _showImageUpdatingNotAvailable, //_showImagePickerOptions,
                      ),
                    ),
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