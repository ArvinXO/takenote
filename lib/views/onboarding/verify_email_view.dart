import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/services/Utils/utils.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/utilities/dialogs/resend_verification_dialog.dart';
import 'package:takenote/widgets/animations/radial_animation.dart';

import '../../../constants/k_constants.dart';
import '../../../widgets/animations/background_colour_animate.dart';
import '../../../widgets/animations/fade_animation.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).size;
    return FadeAnimation(
      delay: 0.2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kOxfordBlue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(const AuthEventUninitialized());
            },
          ),
        ),
        backgroundColor: kRichBlackFogra,
        resizeToAvoidBottomInset: true,
        body: BackgroundColourAnimation(
          delay: 0.1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                FadeAnimation(
                  delay: 1.2,
                  child: Container(
                    width: size.width * 0.9,
                    child: Text(
                      "We've sent you an email for verification",
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          letterSpacing: 1.4),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                //Tap the mail icon! Animated Text
                FadeAnimation(
                  delay: 2,
                  child: const Text(
                    "Psst...Tap me",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                FadeAnimation(
                  delay: 1.2,
                  child: const SizedBox(
                      width: 100, height: 100, child: AnimatedContainerDemo()),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                FadeAnimation(
                  delay: 1.2,
                  child: Container(
                    width: size.width * 0.7,
                    child: Text(
                      "If you haven't verified your email yet, please press the button below",
                      style: GoogleFonts.heebo(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          letterSpacing: 0.3),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                FadeAnimation(
                  delay: 1.2,
                  child: Container(
                    child: TextButton(
                      onPressed: () async {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventSendEmailVerification());
                        // show generic dialog email verification sent successfully
                        await showResendVerificationDialog(context);
                      },
                      child: kSendVerificationContainer,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.11,
                ),
                FadeAnimation(
                  delay: 1.2,
                  child: Center(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
