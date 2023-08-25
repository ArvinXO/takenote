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
  Artboard? _artboard; // Holds the Rive animation artboard

  @override
  void initState() {
    _loadRiveFile(); // Load Rive animation when the widget initializes
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _artboard
        ?.remove(); // Dispose of the Rive animation when the widget is disposed
  }

  // Load the Rive animation from the asset bundle
  _loadRiveFile() async {
    final data = await rootBundle.load('assets/videos/notebook.riv');
    final file = RiveFile.import(data);
    final artboard = file.mainArtboard;
    artboard
        .addController(SimpleAnimation('Animation 1')); // Play the animation
    setState(() => _artboard = artboard); // Update the artboard state
    // Delay for 2 seconds before triggering auth events
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        // Check the auth state and trigger appropriate auth events
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
        child: _artboard != null
            ? Rive(artboard: _artboard!)
            : Container(), // Display the Rive animation or an empty container
      ),
    );
  }
}
