import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// A utility class for managing note colors.
class NoteColor {
  /// Returns a color based on the provided code.
  static Color getColor(int code) {
    switch (code) {
      case 0:
        return FlexColor.blueWhaleDarkPrimary.lighten(20);
      case 1:
        return FlexColor.sakuraLightSecondary.lighten(15);
      case 2:
        return FlexColor.greenDarkPrimary.lighten(10);
      case 3:
        return FlexColor.blueLightPrimary.lighten(40);
      case 4:
        return FlexColor.sakuraLightPrimary.lighten(10);
      case 5:
        return FlexColor.indigoLightSecondary.lighten(40);
      case 6:
        return FlexColor.amberLightPrimary.lighten(10);
      case 7:
        return FlexColor.bigStoneLightSecondary.lighten(10);
      default:
        return Colors.transparent;
    }
  }

  /// Returns a code based on the provided color.
  static int getCode(Color color) {
    if (color == Colors.transparent) {
      return 0;
    } else if (color == const Color(0xFFFCECDD)) {
      return 1;
    } else if (color == const Color(0xffE4FBFF)) {
      return 2;
    } else if (color == const Color(0xffB6C9F0)) {
      return 3;
    } else if (color == const Color(0xffFFE8E8)) {
      return 4;
    } else if (color == const Color(0xffE1CCEC)) {
      return 5;
    } else if (color == const Color(0xffFFF8E1)) {
      return 6;
    } else if (color == const Color(0xffFFF8E1)) {
      return 7;
    } else {
      return 0;
    }
  }
}
