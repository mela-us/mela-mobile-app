import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/personal/store/personal_store.dart';
import 'package:mela/presentation/personal/widgets/headings/personal_info_heading.dart';
import 'package:mela/presentation/personal/widgets/ui_items/decorative_ring.dart';
import 'package:mela/presentation/personal/widgets/dialogs/delete_account_dialog.dart';
import 'package:vibration/vibration.dart';
import '../../core/widgets/image_progress_indicator.dart';
import '../../di/service_locator.dart';
import '../../themes/default/colors_standards.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/routes/routes.dart';
import 'edit_screens/edit_birthdate_screen.dart';
import 'edit_screens/edit_name_screen.dart';

class PersonalInfo extends StatefulWidget {

  const PersonalInfo({
    super.key,
  });

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final PersonalStore _personalStore = getIt<PersonalStore>();

  final ImagePicker _picker = ImagePicker(); //image picker

  @override
  void initState() {
    super.initState();
  }

  void _navigateToEditName() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => EditNameScreen(
                name: _personalStore.user?.name ?? ""
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc ở vị trí gốc
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
  }

  void _navigateToEditBirthdate() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => EditBirthdateScreen(
          dob: _personalStore.user?.dob ?? "",
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
          const end = Offset.zero; // Kết thúc ở vị trí gốc
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
  }

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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      try {
        _showSnackBar("Đang tải ảnh lên...");
        await _personalStore.updateImage(File(pickedFile.path));
        _showSnackBar("Ảnh đại diện đã được cập nhật...");
      } catch (e) {
        _showSnackBar("Không thể tải ảnh của bạn!");
      }
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
      body: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 100,
              right: 220,
              child: DecorativeRing(size: 300, clockwise: false),
            ),
            const Positioned(
              top: 280,
              right: -270,
              child: DecorativeRing(),
            ),
            _buildBody(context),
          ]
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_personalStore.isLoading) {
          return const Center(child: RotatingImageIndicator());
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 10.0), // Spacing before the list
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          PersonalInfoHeading(onChangeImage: _showImagePickerOptions),
                          ..._buildAttributeList(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAttributeList(BuildContext context) {
    return [
      _buildListTile(
          context,
          "Tên học viên",
          _personalStore.user?.name ?? "Người học không tên",
          _navigateToEditName
          , Theme.of(context).colorScheme.textInBg1
      ),
      _buildListTile(
          context,
          "Email",
          _personalStore.user?.email ?? "",
              () {}
          , Theme.of(context).colorScheme.textInBg2
      ),
      _buildListTile(
          context,
          "Ngày sinh",
          _personalStore.user?.dob ?? "",
          _navigateToEditBirthdate
          , Theme.of(context).colorScheme.textInBg1
      ),
      _buildListTile(
          context,
          "Xóa tài khoản",
          "",
          _showDeleteAccountDialog,
          Colors.red
      ),
    ];
  }

  Widget _buildListTile(BuildContext context, String title, String content, VoidCallback onTap, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black26,
        //     blurRadius: 4.0,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 0.0, left: 1.0),
        child: ListTile(
          leading: Text(
              title,
              style: Theme.of(context).textTheme.subTitle
                  .copyWith(color: color)
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .questionStyle
                    .copyWith(color: color),
              ),
              //const SizedBox(width: 8.0),
              const Icon(Icons.arrow_forward_ios_sharp, size: 18.0),
            ],
          ),
          onTap: () {
            onTap();
            Vibration.vibrate(duration: 40);
          },
        ),
      ),
    );
  }
}