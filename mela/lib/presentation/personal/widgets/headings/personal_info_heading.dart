// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../constants/assets.dart';
import '../../../../di/service_locator.dart';
import '../../../../utils/animation_helper/animation_helper.dart';
import '../../../streak/store/streak_store.dart';
import '../../store/personal_store.dart';

class PersonalInfoHeading extends StatefulWidget {
  const PersonalInfoHeading({super.key, required this.onChangeImage});

  final VoidCallback onChangeImage;

  @override
  _PersonalInfoHeadingState createState() => _PersonalInfoHeadingState();
}

class _PersonalInfoHeadingState extends State<PersonalInfoHeading> {

  final PersonalStore _store = getIt<PersonalStore>();

  @override
  Widget build(BuildContext context) {
    return _buildPersonalInfoHeading();
  }

  Widget _buildPersonalInfoHeading() {
    return Observer(
      builder: (context) {
        if (_store.isImageUpdating) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
                child: AnimationHelper.buildShimmerPlaceholder(
                  context, 100, 100,
                )
            ),
          );
        }
        //url
        final url = _store.user?.imageUrl ?? '';
        return Container(
          height: 150.0,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      url,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return AnimationHelper.buildShimmerPlaceholder(context, 100, 100);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.default_profile_pic,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: 5.0),
                  Observer(builder: (_) => const Text("")),
                ],
              ),
              Positioned(
                bottom: 14.8,
                right: -3,
                child: IconButton(
                  icon: Image.asset(
                    "assets/icons/upload_profile_pic.png",
                    width: 30,
                    height: 30,
                  ),
                  onPressed: widget.onChangeImage, //_showImagePickerOptions,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}