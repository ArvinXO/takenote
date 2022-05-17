import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(notesRoute, (route) => false);
              } on FirebaseException catch (e) {
                if (e.code == 'user-not-found') {
                  if (kDebugMode) {
                    print('$e.code');
                  }
                } else if (e.code == 'Wrong Password') {
                  if (kDebugMode) {
                    print('Wrong Password');
                  }
                } else {}
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text('Not registered yet? Register here'),
          ),
        ],
      ),
    );
  }
}
