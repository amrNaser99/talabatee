import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {

  static HexColor primaryColor = HexColor('#3CAA36');
  // static HexColor primaryColor = HexColor('#AF1111');
  static final HexColor secondColor = HexColor('#FFAC00');
  static HexColor whiteColor = HexColor('#FFFFFF');
  static HexColor textColor = HexColor('#2D3142');
  static final scaffoldBackgroundColor = HexColor('#F3F7F9');
  static Color blackColor = Colors.black;
  static final HexColor borderColor = HexColor('#E8E8E8');
  static final HexColor catTextColor = HexColor('#4C5980');
  static final HexColor greyColor = HexColor('#F0F2F4');
  static final HexColor checkColor = HexColor('#339C01');
  static final HexColor lightBlue = HexColor('#DEE9FF');
  static final HexColor cardTextColor = HexColor('#1665D8');
  static final HexColor textButtonColor = HexColor('#1665D8');
  static final HexColor calTextColor = HexColor('#086FB8');
  static final HexColor redColor = HexColor('#F06969');
  static final HexColor cardColor = HexColor('#fbfdff');
  static final HexColor greenColor = HexColor('#4BD40A');

  static final List<Color> scaffoldColors = [
    primaryColor,
    scaffoldBackgroundColor,
  ];


  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
