import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/widgets/animations/fade_animation.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:video_player/video_player.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //video controller
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/splashy.mp4',
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          if (mounted) {}
        });
      })
      ..setVolume(0.0);

    _playVideo();
  }

  void _playVideo() async {
    _controller.play();
    await Future.delayed(const Duration(milliseconds: 1500));
    //
    setState(() {
      //AuthEventInitialize
      if (BlocProvider.of<AuthBloc>(context).state is AuthStateUninitialized) {
        BlocProvider.of<AuthBloc>(context).add(const AuthEventInitializing());
      } else {
        BlocProvider.of<AuthBloc>(context).add(const AuthEventInitialize());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 0.1,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container()),
      ),
    );
  }
}
