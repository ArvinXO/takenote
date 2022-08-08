import 'package:flutter/material.dart';
import 'package:takenote/constants/routes.dart';
import 'package:takenote/services/auth/auth_exceptions.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';

import '../constants/kConstants.dart';

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
        title: const Text("Register"),
        backgroundColor: Colors.blue,
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
              controller: _password,
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              await AuthService.firebase().initialize();
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                if (!mounted) {
                  return;
                }
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await Future.delayed(const Duration(seconds: 1));
                if (!mounted) return;
                {
                  showErrorDialog(
                    context,
                    'Weak Password',
                  );
                }
              } on EmailAlreadyInUseAuthException {
                await Future.delayed(const Duration(seconds: 1));
                if (!mounted) return;
                showErrorDialog(
                  context,
                  'Email already in use',
                );
              } on InvalidEmailAuthException {
                await await Future.delayed(const Duration(seconds: 1));
                if (!mounted) return;
                showErrorDialog(
                  context,
                  'Invalid Email',
                );
              } on GenericAuthException {
                await Future.delayed(const Duration(seconds: 1));
                if (!mounted) return;
                showErrorDialog(
                  context,
                  'Authentication error',
                );
              }
            },
            child: Container(
              height: 50,
              width: 100,
              decoration: gradientButton.copyWith(color: Colors.blue),
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Back to login'),
          ),
        ],
      ),
    );
  }
}

void navVerifyEmailRoute(BuildContext context) {
  Navigator.of(context).pushNamed(verifyEmailRoute);
}
