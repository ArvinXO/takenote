import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_green.dart';

import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';

import '../constants/k_Constants.dart';
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
                height: sizeQuery.height * 0.12,
              ),
              //logo
              Hero(
                tag: "logo",
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: sizeQuery.width * 0.30,
                ),
              ),

              //Align login text to left
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.01,
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
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
              SizedBox(height: sizeQuery.height * 0.00001),
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
                          BoxConstraints(maxHeight: sizeQuery.height * 0.08),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventShouldRegister(),
                          );
                    },
                    child: kRegisterContainer,
                  ),
                  TextButton(
                    onPressed: () async {
                      // if textfields are empty, show error dialog
                      if (_email.text.isEmpty || _password.text.isEmpty) {
                        //print user verified
                        await showErrorDialog(
                            context, 'Please enter your email and password.');
                        if (!mounted) {
                          return;
                        }
                      } else {
                        FocusScope.of(context).unfocus();
                        final email = _email.text;
                        final password = _password.text;
                        context.read<AuthBloc>().add(
                              AuthEventLogIn(
                                email,
                                password,
                              ),
                            );
                      }
                      //Dismiss keyboard
                    },
                    child: kLoginContainer,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventForgotPassword(),
                          );
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
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
