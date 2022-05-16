import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:takenote/constants/routes.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            showCursor: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: _email.clear,
                  icon: const Icon(Icons.clear),
                ),
                hintText: 'Enter your email here'),
          ),
          TextField(
            obscureText: true,
            showCursor: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                suffix: IconButton(
                  onPressed: _password.clear,
                  icon: const Icon(Icons.clear),
                ),
                hintText: 'Enter your password here'),
            controller: _password,
          ),
          TextButton(
            onPressed: () async {
              await Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              );
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('You have entered a Weak password');
                } else if (e.code == 'email-already-in-use') {
                  print('You have entered an email already in use');
                } else if (e.code == 'invalid-email') {
                  print('Invalid email entered');
                }
                print(e.code);
              }

              print(UserCredential);
              print(_email.text);
              print(_password.text);
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: Text('Back to login')),
        ],
      ),
    );
  }
}
