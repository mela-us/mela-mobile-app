
import 'dart:ui';

import 'package:flutter/material.dart';

class TextStandard {

    static Text BigTitle(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'Asap',
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
  static Text Heading(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 21,
        fontFamily: 'Asap',
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static Text SubHeading(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  static Text Title(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  static Text SubTitle(String text, Color color,{TextDecoration decoration = TextDecoration.none}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.bold,
        color: color,
        decoration: decoration,
      ),
    );
  }

  static Text Normal(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static Text Content(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }

  static Text MiniCaption(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static Text Button(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontFamily: 'Asap',
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}