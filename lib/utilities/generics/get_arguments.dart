import 'package:flutter/material.dart' show BuildContext, ModalRoute;

/// A Flutter extension to extract typed arguments from the current route.
extension GetArgument on BuildContext {
  /// Get the typed arguments from the current route.
  ///
  /// Returns the arguments of type [T] if available, otherwise returns `null`.
  T? getArgument<T>() {
    // Get the current modal route from the context.
    final modalRoute = ModalRoute.of(this);

    // Check if a modal route is available.
    if (modalRoute == null) {
      return null;
    }

    // Retrieve the arguments from the modal route settings.
    final args = modalRoute.settings.arguments;

    // Check if arguments are not null and of the expected type [T].
    if (args != null && args is T) {
      return args as T;
    }

    // Return null if the arguments are not of the expected type.
    return null;
  }
}
