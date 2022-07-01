import 'package:flutter/material.dart';
import 'package:takenote/constants/kConstants.dart';

import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/auth_service.dart';

import '../services/auth/auth_exceptions.dart';
import '../utilities/show_error_dialog.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              showCursor: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: IconButton(
                    onPressed: _email.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  labelText: 'Email',
                  hintText: 'Enter your email here'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _password,
              obscureText: true,
              showCursor: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffix: IconButton(
                    onPressed: _password.clear,
                    icon: const Icon(Icons.clear),
                  ),
                  labelText: 'Password',
                  hintText: 'Enter your password here'),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase()
                    .logIn(email: email, password: password);
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  'User not found',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  'Wrong Password',
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  'Authentication error',
                );
              }
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: gradientButton,
              child: const Center(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //TODO FORGOT PASSWORD SCREEN GOES HERE
            },
            child: const Text(
              'Forgot Password',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
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
