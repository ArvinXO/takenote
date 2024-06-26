import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/enums/login_field_control.dart';
import 'package:takenote/services/auth/auth_exceptions.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';
import 'package:takenote/widgets/animations/fade_animation.dart';

import '../../../constants/k_constants.dart';
import '../../../services/auth/bloc/auth_event.dart';
import '../../../widgets/animations/background_colour_animate.dart';
import '../../utilities/utils.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _firstname;
  late final TextEditingController _lastname;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _firstname = TextEditingController();
    _lastname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstname.dispose();
    _lastname.dispose();
    super.dispose();
  }

  Color enabled = const Color(0xFF827F8A);
  Color enabledtxt = Colors.white;
  Color disable = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  RegisterFields? selected;
  @override
  Widget build(BuildContext context) {
    //utils size
    final Size size = Utils(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak password');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Failed to register error');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context, 'Email already in use');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          }
        }
      },
      child: FadeAnimation(
        delay: 0.1,
        child: Scaffold(
          backgroundColor: const Color(0xFF1F1A30),
          resizeToAvoidBottomInset: true,
          body: BackgroundColourAnimation(
            delay: 0.1,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // back to login bloc

                      context.read<AuthBloc>().add(
                            const AuthEventLogOut(),
                          );
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: size.width * 0.04, top: size.height * 0.04),
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                        size: 35.0,
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 0.8,
                    child: Image.asset(
                      'assets/images/reg.png',
                      height: size.height * 0.18,
                      width: size.width * 0.7,
                    ),
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: size.width * 0.8,
                      child: Text(
                        "Register",
                        style: GoogleFonts.heebo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    delay: 1.2,
                    child: Container(
                      width: size.width * 0.8,
                      child: Text(
                        "Please fill in the form to register",
                        style: GoogleFonts.heebo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 1.4),
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
                          color: selected == RegisterFields.firstname
                              ? kJungleDarkGreen.withOpacity(1)
                              : kJungleDarkGreen.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                        // color: selected == RegisterFields.Email
                        //     ? enabled
                        //     : backgroundColor,
                      ),
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: _firstname,
                        clipBehavior: Clip.antiAlias,
                        onTap: () {
                          setState(() {
                            selected = RegisterFields.firstname;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.perm_identity_sharp,
                            color: selected == RegisterFields.firstname
                                ? enabledtxt
                                : disable,
                          ),
                          hintText: 'First name',
                          hintStyle: TextStyle(
                            color: selected == RegisterFields.firstname
                                ? enabledtxt
                                : disable,
                          ),
                        ),
                        style: TextStyle(
                            color: selected == RegisterFields.firstname
                                ? enabledtxt
                                : disable,
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
                          color: selected == RegisterFields.lastname
                              ? kJungleDarkGreen.withOpacity(1)
                              : kJungleDarkGreen.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                        // color: selected == RegisterFields.Email
                        //     ? enabled
                        //     : backgroundColor,
                      ),
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: _lastname,
                        clipBehavior: Clip.antiAlias,
                        onTap: () {
                          setState(() {
                            selected = RegisterFields.lastname;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.perm_identity_sharp,
                            color: selected == RegisterFields.lastname
                                ? enabledtxt
                                : disable,
                          ),
                          hintText: 'Last name',
                          hintStyle: TextStyle(
                            color: selected == RegisterFields.lastname
                                ? enabledtxt
                                : disable,
                          ),
                        ),
                        style: TextStyle(
                            color: selected == RegisterFields.lastname
                                ? enabledtxt
                                : disable,
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
                          color: selected == RegisterFields.Email
                              ? kJungleDarkGreen.withOpacity(1)
                              : kJungleDarkGreen.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                        // color: selected == RegisterFields.Email
                        //     ? enabled
                        //     : backgroundColor,
                      ),
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: _email,
                        clipBehavior: Clip.antiAlias,
                        onTap: () {
                          setState(() {
                            selected = RegisterFields.Email;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: selected == RegisterFields.Email
                                ? enabledtxt
                                : disable,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: selected == RegisterFields.Email
                                ? enabledtxt
                                : disable,
                          ),
                        ),
                        style: TextStyle(
                            color: selected == RegisterFields.Email
                                ? enabledtxt
                                : disable,
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
                          color: selected == RegisterFields.password
                              ? kJungleDarkGreen.withOpacity(1)
                              : kJungleDarkGreen.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                        // color: selected == RegisterFields.password
                        //     ? enabled
                        //     : backgroundColor,
                      ),
                      child: TextField(
                        controller: _password,
                        clipBehavior: Clip.antiAlias,
                        onTap: () {
                          setState(() {
                            selected = RegisterFields.password;
                          });
                        },
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            //Border when not selected
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: selected == RegisterFields.password
                                  ? enabledtxt
                                  : disable,
                            ),
                            suffixIcon: IconButton(
                              icon: ispasswordev
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: selected == RegisterFields.password
                                          ? enabledtxt
                                          : disable,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: selected == RegisterFields.password
                                          ? enabledtxt
                                          : disable,
                                    ),
                              onPressed: () =>
                                  setState(() => ispasswordev = !ispasswordev),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: selected == RegisterFields.password
                                    ? enabledtxt
                                    : disable)),
                        obscureText: ispasswordev,
                        style: TextStyle(
                            color: selected == RegisterFields.password
                                ? enabledtxt
                                : disable,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: size.height * 0.01,
                          ),
                          // Register button covers left and right 7% of screen
                          child: SizedBox(
                            width: size.width * 0.5,
                            height: size.height * 0.07,
                            // curved edges

                            child: ElevatedButton(
                              style: //oxford blue

                                  ElevatedButton.styleFrom(
                                backgroundColor: kBdazalledBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () async {
                                final email = _email.text;
                                final password = _password.text;
                                final firstname = _firstname.text;
                                final lastname = _lastname.text;
                                await AuthService.firebase().initialize();
                                if (!mounted) {
                                  return;
                                }

                                //if email or password is empty
                                if (email.isEmpty || password.isEmpty) {
                                  await showErrorDialog(
                                      context, 'Email or password is empty');
                                  return;
                                  // Snackbar
                                } else {
                                  context.read<AuthBloc>().add(
                                        AuthEventRegister(
                                          email,
                                          password,
                                          firstname,
                                          lastname,
                                          //firstname could be null check
                                        ),
                                      );
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.09,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: GoogleFonts.heebo(
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                )),
                            TextButton(
                                style: TextButton.styleFrom(),
                                onPressed: () {
                                  if (!mounted) {
                                    return;
                                  }
                                  context.read<AuthBloc>().add(
                                        const AuthEventLogOut(),
                                      );
                                },
                                child: Text(
                                  "Log in",
                                  style: GoogleFonts.heebo(
                                    color: const Color(0xFF0DF5E4)
                                        .withOpacity(0.9),
                                    letterSpacing: 0.5,
                                  ),
                                )),
                          ],
                        ),
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
