import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_green.dart';
import 'package:takenote/constants/k_constants.dart';

import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';

import '../services/auth/auth_exceptions.dart';
import '../services/auth/bloc/auth_event.dart';
import '../utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
    Size sizeQuery = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        //Screen size mediaQuery is used to get the height and width of the screen
        if (state is AuthStateLoggedOut) {
          kDebugMode
              ? print('Logged out')
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out'),
                  ),
                );
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
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(239, 246, 236, 0.98),
        resizeToAvoidBottomInset: false,
        body: GreenBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeQuery.height * 0.07,
              ),
              //logo
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Hero(
              //     tag: "logo",
              //     child: Image.asset(
              //       'assets/icon/icontext.png',
              //       width: sizeQuery.width * 0.6,
              //     ),
              //   ),
              // ),

              //Align login text to left
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.06,
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
              SizedBox(height: sizeQuery.height * 0.01),

              Padding(
                padding: k3010LRpad,
                child: TextField(
                  //overflow textfield
                  controller: _email,
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
                        onPressed: _email.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      hintText: 'Email'),
                ),
              ),
              Padding(
                padding: k3010LRpad,
                child: TextField(
                  //white background
                  controller: _password,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  enableSuggestions: false,
                  autocorrect: false,
                  clipBehavior: Clip.antiAlias,
                  decoration: InputDecoration(
                      constraints:
                          BoxConstraints(maxHeight: sizeQuery.height * 0.07),
                      //white background
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                      suffix: IconButton(
                        onPressed: _password.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      hintText: 'Password'),
                ),
              ),
              // Wrap button to the right side
              // login button size is 0.4 of the screen
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.01,
                ),
                child: SizedBox(
                  width: sizeQuery.width * 0.85,
                  height: sizeQuery.height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kJungleGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_email.text.isEmpty || _password.text.isEmpty) {
                        //print user verified
                        await showErrorDialog(
                            context, 'Please enter your email and password.');
                        if (!mounted) {
                          return;
                        }
                      } else {
                        // else if login is successful, show loading dialog

                        FocusScope.of(context).unfocus();
                        // loading dialog

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
                    child: const Text('Login'),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.0000001,
                ),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: kRichBlackFogra, fontSize: 15),
                  ),
                ),
              ),
              //Divider
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.01,
                ),
                child: const Text(
                  'OR',
                  style: TextStyle(
                    color: kRichBlackFogra,
                    fontSize: 15,
                  ),
                ),
              ),
              //divider line
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.01,
                ),
                child: const Divider(
                  color: kRichBlackFogra,
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventShouldRegister(),
                          );
                    },
                    child: const Text(
                      'Need an account? Register',
                      style: TextStyle(color: kRichBlackFogra, fontSize: 15),
                    ),
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
