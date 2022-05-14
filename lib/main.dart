import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:takenote/views/login_views.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:takenote/views/register_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            // if (user?.emailVerified ?? false) {
            // } else {
            //   print(user);
            //   return const VerifiyEmailView();
            // }
            // return const Text('Done.....');
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
