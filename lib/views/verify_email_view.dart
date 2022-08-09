import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';

import '../constants/kConstants.dart';

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
      body: Padding(
        padding: k10pad,
        child: Column(
          children: [
            const Text(
                "We've sent you an email for verification, please open it to verify your account"),
            const Text(
                "If you haven't verified your email yet, please press the button below"),
            TextButton(
              onPressed: () async {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text('Send email verification'),
            ),
            TextButton(
              onPressed: () async {
                if (!mounted) return;
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
