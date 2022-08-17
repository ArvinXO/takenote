import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_blue.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/utilities/dialogs/resend_verification_dialog.dart';
import 'package:takenote/widgets/radial_animation.dart';

import '../constants/k_constants.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, // the SingleTickerProviderStateMixin
        duration: const Duration(seconds: 1))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _controller.forward(from: 0);
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kGreenBackground,
      resizeToAvoidBottomInset: false,
      body: BlueBackground(
        child: Column(
          children: [
            SizedBox(
              height: sizeQuery.height * 0.14,
            ),
            const Padding(
              padding: EdgeInsets.all(68.0),
              child: Text(
                "We've sent you an email for verification, please open it to verify your account!",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(
                width: 100, height: 100, child: AnimatedContainerDemo()),
            SizedBox(
              height: sizeQuery.height * 0.09,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "If you haven't verified your email yet, please press the button below",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: sizeQuery.height * 0.02,
            ),
            TextButton(
              onPressed: () async {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
                // show generic dialog email verification sent successfully
                await showResendVerificationDialog(context);
              },
              child: kSendVerificationContainer,
            ),
            SizedBox(
              height: sizeQuery.height * 0.01,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  if (!mounted) return;
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: kRestartContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
