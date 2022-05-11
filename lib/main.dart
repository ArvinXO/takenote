import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:takenote/views/login_views.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {}
              return const Text('Done');
            default:
              return const Text('Loading.....');
          }
        },
      ),
    );
  }
}
