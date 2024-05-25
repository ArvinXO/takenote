import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// A utility class for managing note colors.
/// //Map color code mapping ++ Performance
class NoteColor {
  static final Map<int, Color> colorMap = {
    0: FlexColor.blueWhaleDarkPrimary.lighten(20),
    1: FlexColor.sakuraLightSecondary.lighten(15),
    2: FlexColor.greenDarkPrimary.lighten(10),
    3: FlexColor.blueLightPrimary.lighten(40),
    4: FlexColor.sakuraLightPrimary.lighten(10),
    5: FlexColor.indigoLightSecondary.lighten(40),
    6: FlexColor.amberLightPrimary.lighten(10),
    7: FlexColor.bigStoneLightSecondary.lighten(10),
  };

  static Color getColor(int code) {
    return colorMap[code] ?? Colors.transparent;
  }

  static int getCode(Color color) {
    for (var entry in colorMap.entries) {
      if (entry.value == color) {
        return entry.key;
      }
    }
    return 0;
  }
}
