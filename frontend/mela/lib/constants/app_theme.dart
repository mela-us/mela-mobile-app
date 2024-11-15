/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your setting, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created setting or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/setting.dart';`
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
  themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF202244), //textInBackGround1
    primaryContainer: Color(0xFF9e1718),

    secondary: Color(0xFF545454), //textInBackGround2
    secondaryContainer: Color(0xFFFAFBFB),

    tertiary: Color(0xFF0961F5), //Button YesColor1
    onTertiary: Color(0xFFFFFFFF), //Button YesColor2 + backgroundTextFormColor

    surface: Color(0xFFF5F9FF), //AppBackgroundColor

    inversePrimary: Color(0xFF167F71), //backgroundButtonChooseColor
    inverseSurface: Color(0xFFE8F1FF), //backgroundButtonNoChooseColor

    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: Color(0xFF202244), //AppBarContentColor
    onSecondary: Color(0xFFB4BDC4), //guideTextColor
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF202244), //textInBackGround1
    primaryContainer: Color(0xFF9e1718),

    secondary: Color(0xFF545454), //textInBackGround2
    secondaryContainer: Color(0xFFFAFBFB),

    tertiary: Color(0xFF0961F5), //ButtonnYesColor1
    onTertiary: Color(0xFFFFFFFF), //ButtonnYesColor2 + backgroundTextFormColor

    surface: Color(0xFFF5F9FF), //AppBackgroundColor

    inversePrimary: Color(0xFF167F71), //backgroundButtonChooseColor
    inverseSurface: Color(0xFFE8F1FF), //backgroundButtonNoChooseColor

    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: Color(0xFF202244), //AppBarContentColor
    onSecondary: Color(0xFFB4BDC4), //guideTextColor
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  // static const _regular = FontWeight.w400;
  // static const _medium = FontWeight.w500;
  // static const _semiBold = FontWeight.w600;
  // static const _bold = FontWeight.w700;

  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontFamily: 'Asap',
      fontWeight: FontWeight.bold,
    ), // BigTitle

    headlineMedium: TextStyle(
      fontSize: 21,
      fontFamily: 'Asap',
      fontWeight: FontWeight.bold,
    ), // Heading

    titleLarge: TextStyle(
      fontSize: 20,
      fontFamily: 'Asap',
      fontWeight: FontWeight.w600,
    ), // Title

    bodyLarge: TextStyle(
      fontSize: 18,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.w600,
    ), // SubHeading

    bodyMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.normal,
    ), // Content

    titleMedium: TextStyle(
      fontSize: 14,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.bold,
    ), // SubTitle

    labelMedium: TextStyle(
      fontSize: 13,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.bold,
    ), // Normal

    labelSmall: TextStyle(
      fontSize: 11,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.bold,
    ), // MiniCaption

    titleSmall: TextStyle(
      fontSize: 18,
      fontFamily: 'Asap',
      fontWeight: FontWeight.w600,
    ), // Button
    displaySmall: TextStyle(
      fontSize: 14,
      fontFamily: 'Mulish',
      fontWeight: FontWeight.normal,
    ),//QuestionStyle
  );

}

// Extension to call follow figma text theme
extension CustomTextTheme on TextTheme {
  TextStyle get bigTitle => headlineLarge!;
  TextStyle get heading => headlineMedium!;
  TextStyle get title => titleLarge!;
  TextStyle get subHeading => bodyLarge!;
  TextStyle get content => bodyMedium!;
  TextStyle get subTitle => titleMedium!;
  TextStyle get normal => labelMedium!;
  TextStyle get miniCaption => labelSmall!;
  TextStyle get buttonStyle => titleSmall!;
  TextStyle get questionStyle => displaySmall!;
}

extension CustomColorTheme on ColorScheme{
  Color get appBackground => const Color(0xFFF5F9FF);
  Color get textInBg1 => const Color(0xFF202244);
  Color get textInBg2 => const Color(0xFF545454);
  Color get dialogBackground => const Color(0xFF202244);

  Color get buttonStroke => const Color(0xFFD6DCE1);
  //Màu sắc của nút câu hỏi khi đã chọn
  Color get buttonList => const Color(0xFFC6DCFF);

  Color get buttonCorrect => const Color(0xFF8EFF97);
  Color get buttonIncorrect => const Color(0xFFFFD5DB);

  Color get buttonYesBgOrText => const Color(0xFF0961F5);
  Color get buttonYesTextOrBg => const Color(0xFFFFFFFF);

  Color get buttonNoBackground => const Color(0xFFE8F1FF);
  Color get buttonNoBorder => const Color(0xFFB4BDC4);
  Color get buttonNoText => const Color(0xFF202244);

  Color get buttonChooseBackground => const Color(0xFF167F71);
  Color get buttonChooseText => const Color(0xFFFFFFFF);

  Color get buttonNoChooseBackground => const Color(0xFFE8F1FF);
  Color get buttonNoChooseText => const Color(0xFF202244);

  Color get inputBackground => const Color(0xFFFFFFFF);
  Color get inputText => const Color(0xFF505050);
  Color get inputTitleText => const Color(0xFF393939);
  Color get inputMutedText => const Color(0xFFE9E9E9);
  Color get inputHintText => const Color(0xFFB4BDC4);
}