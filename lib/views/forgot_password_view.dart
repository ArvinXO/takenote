import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';

import '../utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            if (!mounted) {
              return;
            }
            await showErrorDialog(context,
                'We could not process your request. Please make sure that you are a registered user. If not, please try again later.');
            if (!mounted) {
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.exception.toString()),
              ),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forgot Password',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Text(
                'Please enter your email address and we will send you a link to reset your password.',
              ),
              TextField(
                //Email
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,

                decoration: const InputDecoration(
                  labelText: 'Your Email address...',
                ),
              ),
              TextButton(
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(email: email));
                },
                child: const Text('Send password reset link'),
              ),
              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text('Back to login page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
