import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_orange.dart';
import 'package:takenote/constants/k_constants.dart';
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
        backgroundColor: kTuscany.withOpacity(0.3),
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
                child: const Center(
                  child: Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.01),
              Padding(
                padding: k3010LRpad,
                child: TextField(
                  //overflow textfield
                  controller: _controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  showCursor: true,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      //overflow text if text is too long
                      constraints:
                          BoxConstraints(maxHeight: sizeQuery.height * 0.08),
                      //black border
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _controller.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      hintText: 'Email'),
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: sizeQuery.width * 0.07,
                      vertical: sizeQuery.height * 0.01,
                    ),
                    // Register button covers left and right 7% of screen
                    child: SizedBox(
                      width: sizeQuery.width * 0.85,
                      height: sizeQuery.height * 0.07,
                      // curved edges

                      child: ElevatedButton(
                        style: //oxford blue

                            ElevatedButton.styleFrom(
                          backgroundColor: kBdazalledBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // if user doesnt enter email then keep the colour else change to orange
                        onPressed: () {
                          final email = _controller.text;
                          context
                              .read<AuthBloc>()
                              .add(AuthEventForgotPassword(email: email));
                        },
                        child: kSendResetLinkContainer,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sizeQuery.height * 0.001),
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
