import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:takenote/constants/k_constants.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';

//Animated container
class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({Key? key}) : super(key: key);
  @override
  AnimatedContainerDemoState createState() => AnimatedContainerDemoState();
}

//Animated container state
class AnimatedContainerDemoState extends State<AnimatedContainerDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeQuery = MediaQuery.of(context).size;

    return AnimatedBuilder(
        animation: _controller.view,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                width: sizeQuery.width * 0.6,
                height: sizeQuery.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 3,
                      spreadRadius: 5,
                      offset: const Offset(1, 1),
                    )
                  ],
                  gradient: SweepGradient(
                      startAngle: 0,
                      colors: const [
                        Colors.black,
                        Colors.blue,
                      ],
                      transform: GradientRotation(_controller.value * 10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: sizeQuery.width * 0.25,
                    height: sizeQuery.height * 0.09,
                    decoration: BoxDecoration(
                      color: kBdazalledBlue,
                      borderRadius: BorderRadius.circular(10),
                      gradient: SweepGradient(
                          startAngle: 0.6,
                          colors: const [Colors.black, Colors.blue],
                          transform: GradientRotation(_controller.value * 10)),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        // Android: Will open mail app or show native picker.
                        // iOS: Will open mail app if single mail app found.
                        var result = await OpenMailApp.openMailApp(
                          nativePickerTitle: 'Select mail app to open mail',
                        );

                        // If no mail apps found, show error
                        if (!result.didOpen && !result.canOpen) {
                          if (!mounted) {}
                          showErrorDialog(context, 'No mail apps found');

                          // iOS: if multiple mail apps found, show dialog to select.
                          // There is no native intent/default app system in iOS so
                          // you have to do it yourself.
                        }
                      },
                      tooltip: 'Open mail app',
                      icon: ScaleTransition(
                        scale: Tween<double>(begin: 0.75, end: 1.0)
                            .animate(_controller),
                        child: const Icon(Icons.mail,
                            color: Colors.white,
                            size: 70,
                            shadows: [
                              Shadow(
                                blurRadius: 60,
                                color: kOxfordBlue,
                                offset: Offset(5, 5),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
