import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email for verification, please open it to verify your account"),
          const Text(
              "If you haven't verified your email yet, please press the button below"),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send email verification'),
          )
        ],
      ),
    );
  }
}
