import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/services/Utils/utils.dart';
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
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
        vsync: this, // the SingleTickerProviderStateMixin
        duration: const Duration(seconds: 10))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _animation;
      })
      ..addListener(() {
        setState(() {});
      });
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
    _animation.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).size;
    return Scaffold(
      backgroundColor: kRichBlackFogra,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            const Padding(
              padding: EdgeInsets.all(98.0),
              child: Text(
                "We've sent you an email for verification, please open it to verify your account!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            //Tap the mail icon! Animated Text
            ScaleTransition(
              scale: Tween<double>(begin: 1, end: 1.2).animate(_controller),
              child: const Text(
                "Psst...Tap me",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            const SizedBox(
                width: 100, height: 100, child: AnimatedContainerDemo()),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: Padding(
                padding: EdgeInsets.all(28.0),
                child: Text(
                  "If you haven't verified your email yet, please press the button below",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
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
              height: size.height * 0.11,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  if (!mounted) return;
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: Text(
                  "Return to login",
                  style: GoogleFonts.heebo(
                    color: const Color(0xFF0DF5E4).withOpacity(0.9),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
