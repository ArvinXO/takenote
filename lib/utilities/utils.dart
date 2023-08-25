import 'package:flutter/material.dart';

/// A utility class for managing common functions related to the UI.
class Utils {
  final BuildContext context;

  /// Constructor that accepts a [context] parameter.
  Utils(this.context);

  /// Returns the size of the current screen.
  Size get size => MediaQuery.of(context).size;
}
