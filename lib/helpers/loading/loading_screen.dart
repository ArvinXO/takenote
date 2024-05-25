import 'dart:async';

import 'package:flutter/material.dart';
import 'package:takenote/constants/k_constants.dart'; // Importing constants
import 'package:takenote/helpers/loading/loading_screen_controller.dart'; // Importing the LoadingScreenController

class LoadingScreen {
  factory LoadingScreen() => _shared; // Creating a singleton instance
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController?
      controller; // Controller to manage the loading screen

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (controller?.update(text) ?? false) {
      return; // If loading is already showing and text is being updated, return
    } else {
      controller = showOverlay(
        context: context,
        text: text,
      ); // Otherwise, show the loading overlay
    }
  }

  void hide() {
    controller?.close(); // Close the loading overlay
    controller = null;
  }

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final textStream =
        StreamController<String>(); // Stream to manage text changes
    textStream.add(text); // Initial text value
    final state = Overlay.of(context); // Get the overlay state
    final renderBox =
        context.findRenderObject() as RenderBox; // Get render box for size
    final size = renderBox.size; // Get the size of the widget

    final overlay = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withAlpha(40), // Semi-transparent black background
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: size.width * 0.9, // Set maximum height for the overlay
              maxWidth: size.width * 0.8, // Set maximum width for the overlay
              minWidth: size.width * 0.7, // Set minimum width for the overlay
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              color: Colors.white, // White background
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    k20SizedBox, // A constant-sized box for spacing

                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ), // Circular progress indicator

                    k20SizedBox, // Another constant-sized box for spacing

                    StreamBuilder(
                      stream: textStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data as String,
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ), // StreamBuilder for the text message
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    state.insert(overlay); // Insert the overlay into the overlay state

    return LoadingScreenController(
      close: () {
        textStream.close(); // Close the text stream
        overlay.remove(); // Remove the overlay
        return true;
      },
      update: (text) {
        textStream.add(text); // Update the text in the stream
        return true;
      },
    );
  }
}
