import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_orange.dart';
import 'package:takenote/constants/k_Constants.dart';
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
    Size sizeQuery = MediaQuery.of(context).size;
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
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 205, 128, 0.95),
        resizeToAvoidBottomInset: false,
        body: OrangeBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeQuery.height * 0.22,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.01,
                ),
                child: const Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.01),
              Padding(
                padding: k3010LRpad,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: TextField(
                    //Email
                    controller: _controller,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    cursorColor: Colors.orange,
                    decoration: kForgotPasswordContainerDecoration,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      final email = _controller.text;
                      context
                          .read<AuthBloc>()
                          .add(AuthEventForgotPassword(email: email));
                    },
                    child: kSendResetLinkContainer,
                  ),
                ],
              ),
              SizedBox(height: sizeQuery.height * 0.15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    child: kBackToLoginContainer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
