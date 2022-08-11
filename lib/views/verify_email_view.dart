import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:takenote/components/background_blue.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_event.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';
import 'package:takenote/utilities/dialogs/resend_verification_dialog.dart';

import '../constants/k_constants.dart';

class VerifiyEmailView extends StatefulWidget {
  const VerifiyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifiyEmailView> createState() => _VerifiyEmailViewState();
}

class _VerifiyEmailViewState extends State<VerifiyEmailView> {
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
            Container(
              width: sizeQuery.width * 0.25,
              height: sizeQuery.height * 0.09,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () async {
                  // Android: Will open mail app or show native picker.
                  // iOS: Will open mail app if single mail app found.
                  var result = await OpenMailApp.openMailApp(
                    nativePickerTitle: 'Select mail app to open mail',
                  );

                  // If no mail apps found, show error
                  if (!result.didOpen && !result.canOpen) {
                    if (!mounted) {}
                    showErrorDialog(context, 'No mail apps found');

                    // iOS: if multiple mail apps found, show dialog to select.
                    // There is no native intent/default app system in iOS so
                    // you have to do it yourself.
                  }
                },
                tooltip: 'Open mail app',
                icon: const Icon(Icons.mail,
                    color: Colors.white,
                    size: 100,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.blue,
                        offset: Offset(5, 5),
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: sizeQuery.height * 0.09,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 60,
                right: 60,
              ),
              child: Text(
                "If you haven't verified your email yet, please press the button below",
                style: TextStyle(color: Colors.white, fontSize: 14),
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
