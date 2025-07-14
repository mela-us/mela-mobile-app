import 'package:flutter/material.dart';
import 'package:mela/constants/dimens.dart';

class Layout {
  Layout._();

  // For all screen:------------------------------------------------------------

  // For practice (question, review, result):-----------------------------------
  static BoxShadow practiceBoxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 2,
    blurRadius: 5,
    offset: const Offset(0, 3), // Đổ bóng
  );

  static const EdgeInsets practiceContainerPaddingWithTop = EdgeInsets.fromLTRB(
      Dimens.practiceLeftContainer,
      Dimens.practiceTopContainer,
      Dimens.practiceRightContainer,
      0.0
  );

  static const EdgeInsets practiceContainerPadding = EdgeInsets.fromLTRB(
      Dimens.practiceLeftContainer, 0.0, Dimens.practiceRightContainer, 0.0);

  static const EdgeInsets practiceTextPadding = EdgeInsets.symmetric(
      vertical: Dimens.practiceVerticalText,
      horizontal: Dimens.practiceHorizontalText
  );
}



