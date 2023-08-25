import 'package:flutter/material.dart';

// Type alias for the function that closes the loading screen
typedef CloseLoadingScreen = bool Function();

// Type alias for the function that updates the loading screen text
typedef UpdateLoadingScreen = bool Function(String text);

// The LoadingScreenController class to manage the loading screen
@immutable
class LoadingScreenController {
  // Function to close the loading screen
  final CloseLoadingScreen close;

  // Function to update the loading screen text
  final UpdateLoadingScreen update;

  // Constructor to initialize the controller with required functions
  const LoadingScreenController({
    required this.close, // Function to close the loading screen
    required this.update, // Function to update the loading screen text
  });
}
