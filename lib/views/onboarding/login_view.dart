import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/constants/k_constants.dart';

import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';

import '../../../widgets/animations/background_colour_animate.dart';
import '../../../widgets/animations/fade_animation.dart';
import '../../../enums/login_field_control.dart';
import '../../utilities/utils.dart';
import '../../../services/auth/auth_exceptions.dart';
import '../../../services/auth/bloc/auth_event.dart';
import '../../../utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  Color enabled = const Color(0xFF827F8A);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  LoginFields? selected;

  //TitleBar for AppBar that can change depending on the state of the AuthBloc

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

//implement screenSize and screenWidth from device

  @override
  Widget build(BuildContext context) {
    final Size size = Utils(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
                context, 'Cannot find user with entered credentials.');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong password');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: FadeAnimation(
        delay: 0.1,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BackgroundColourAnimation(
            delay: 1,
            child: SingleChildScrollView(
              //Prevent textfield from being covered by keyboard

              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  FadeAnimation(
                    delay: 0.8,
                    child: Image.asset(
                      'assets/images/signin.png',
                      height: size.height * 0.2,
                      width: size.width * 0.7,
                    ),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      width: size.width * 0.85,
                      child: Text(
                        "Login",
                        style: GoogleFonts.heebo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      width: size.width * 0.85,
                      child: Text(
                        "Please sign in to continue",
                        style: GoogleFonts.heebo(
                            color: Colors.grey, letterSpacing: 0.5),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: size.width * 0.7, //width of the TextField Widget
                      height: size.height * 0.01,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.07,
                        vertical: size.height * 0.06,
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kJungleGreen,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 90),
                  FadeAnimation(
                    delay: 1.2,
                    child: Container(
                      width: size.width * 0.88, //width of the TextField Widget
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: selected == LoginFields.Email
                                ? kJungleDarkGreen.withOpacity(1)
                                : kJungleDarkGreen.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                          color: selected == LoginFields.Email
                              ? enabled
                              : backgroundColor),
                      child: TextFormField(
                        controller: _email,
                        onTap: () {
                          setState(() {
                            selected = LoginFields.Email;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: selected == LoginFields.Email
                                ? enabledtxt
                                : deaible,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: selected == LoginFields.Email
                                ? enabledtxt
                                : deaible,
                          ),
                        ),
                        style: TextStyle(
                            color: selected == LoginFields.Email
                                ? enabledtxt
                                : deaible,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: size.width * 0.88, //width of the TextField Widget
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: selected == LoginFields.password
                              ? kJungleDarkGreen.withOpacity(1)
                              : kJungleDarkGreen.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                        color: selected == LoginFields.password
                            ? enabled
                            : backgroundColor,
                      ),
                      child: TextFormField(
                        controller: //null check
                            _password,
                        // _password,
                        onTap: () {
                          setState(() {
                            selected = LoginFields.password;
                          });
                        },
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: selected == LoginFields.password
                                  ? enabledtxt
                                  : deaible,
                            ),
                            suffixIcon: IconButton(
                              icon: ispasswordev
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: selected == LoginFields.password
                                          ? enabledtxt
                                          : deaible,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: selected == LoginFields.password
                                          ? enabledtxt
                                          : deaible,
                                    ),
                              onPressed: () =>
                                  setState(() => ispasswordev = !ispasswordev),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: selected == LoginFields.password
                                    ? enabledtxt
                                    : deaible)),
                        obscureText: ispasswordev,
                        style: TextStyle(
                            color: selected == LoginFields.password
                                ? enabledtxt
                                : deaible,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  FadeAnimation(
                    delay: 1.2,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                        vertical: size.height * 0.01,
                      ),
                      child: SizedBox(
                        width: size.width * 0.55,
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kJungleGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            //circuluar progress indicator

                            if (_email.text.isEmpty || _password.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Please enter email and password',
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: Colors.red.withOpacity(0.8),
                                ),
                              );
                              //print user verified
                              await showErrorDialog(context,
                                  'Please enter your email and password.');
                              if (!mounted) {
                                return;
                              }
                            } else {
                              // else if login is successful, show loading dialog

                              FocusScope.of(context).unfocus();
                              // loading dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Logging in',
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor:
                                      kJungleGreen.withOpacity(0.8),
                                ),
                              );
                              if (!mounted) {
                                return;
                              }

                              final email = _email.text;
                              final password = _password.text;
                              context.read<AuthBloc>().add(
                                    AuthEventLogIn(
                                      email,
                                      password,
                                    ),
                                  );

                              BlocProvider.of<AuthBloc>(context)
                                  .add(const AuthEventInitialize());
                              // loading screen

                              // show dialog loading then remove circular progress indicator  after 2 seconds
                            }
                          },
                          //CircularProgressIndicator or login text depending on loading state
                          child: //If AuthBloc is in loading state, show circular progress indicator
                              //else show login text
                              const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.0001,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              const AuthEventForgotPassword(),
                            );
                      },
                      child: Text("Forgot password?",
                          style: GoogleFonts.heebo(
                            color: const Color(0xFF0DF5E4).withOpacity(0.9),
                            letterSpacing: 0.5,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.23,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",
                            style: GoogleFonts.heebo(
                              color: Colors.grey,
                              letterSpacing: 0.5,
                            )),
                        TextButton(
                            style: TextButton.styleFrom(),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    const AuthEventShouldRegister(),
                                  );
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.heebo(
                                color: const Color(0xFF0DF5E4).withOpacity(0.9),
                                letterSpacing: 0.5,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
