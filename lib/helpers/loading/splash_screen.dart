import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';

import '../../services/auth/bloc/auth_bloc.dart';
import '../../services/auth/bloc/auth_state.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //video controller
  Artboard? _artboard;

  @override
  void initState() {
    _loadRiveFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _artboard?.remove();
  }

  _loadRiveFile() async {
    // Load your Rive data
    final data = await rootBundle.load('assets/videos/notebook.riv');
    // Create a RiveFile from the binary data
    final file = RiveFile.import(data);
    // Get the artboard containing the animation you want to play
    final artboard = file.mainArtboard;
    // Create a SimpleAnimation controller for the animation you want to play
    // and attach it to the artboard
    artboard.addController(SimpleAnimation('Animation 1'));
    // Wrapped in setState so the widget knows the animation is ready to play
    setState(() => _artboard = artboard);
    // play for 3 seconds then bloc to login
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        //AuthEventInitialize
        if (BlocProvider.of<AuthBloc>(context).state
            is AuthStateUninitialized) {
          BlocProvider.of<AuthBloc>(context).add(const AuthEventInitializing());
        } else {
          BlocProvider.of<AuthBloc>(context).add(const AuthEventInitialize());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _artboard != null ? Rive(artboard: _artboard!) : Container(),
      ),
    );
  }
}
