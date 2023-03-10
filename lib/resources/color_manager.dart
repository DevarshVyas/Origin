import 'package:flutter/material.dart';

class ColorManager {
  static  Color primary = HexColor.fromHex("#E8FEBE");
  static  Color green = HexColor.fromHex("#8BC53F");
  static  Color amber = HexColor.fromHex("#8B8000");
  static Color black = HexColor.fromHex("#333333");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");

  static Color darkPrimary = HexColor.fromHex("#1E8040");
  static Color red = HexColor.fromHex("#B11F1F");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 Char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
