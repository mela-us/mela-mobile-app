import 'dart:io';

import 'package:mela/constants/enum.dart';

class UserUpdateParam {
  final String value;
  final File? image;
  final UpdateField field;

  UserUpdateParam(this.image, {required this.value, required this.field});
}