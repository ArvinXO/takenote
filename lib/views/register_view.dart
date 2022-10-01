import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_blue.dart';
import 'package:takenote/services/auth/auth_exceptions.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';

import '../constants/k_constants.dart';
import '../services/Utils/utils.dart';
import '../services/auth/bloc/auth_event.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(233, 242, 249, 0.99),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: BlueBackground(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                    vertical: size.height * 0.06,
                  ),
                  child: kRegisterText,
                ),
                SizedBox(height: size.height * 0.01),
                Padding(
                  padding: k3010LRpad,
                  child: TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    showCursor: true,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        //overflow text if text is too long
                        constraints:
                            BoxConstraints(maxHeight: size.height * 0.08),
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
                            BoxConstraints(maxHeight: size.height * 0.07),
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
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.07,
                        vertical: size.height * 0.01,
                      ),
                      // Register button covers left and right 7% of screen
                      child: SizedBox(
                        width: size.width * 0.85,
                        height: size.height * 0.07,
                        // curved edges

                        child: ElevatedButton(
                          style: //oxford blue

                              ElevatedButton.styleFrom(
                            backgroundColor: kBdazalledBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            await AuthService.firebase().initialize();
                            if (!mounted) {
                              return;
                            }
                            //if email or password is empty
                            if (email.isEmpty || password.isEmpty) {
                              await showErrorDialog(
                                  context, 'Email or password is empty');
                              return;
                            } else {
                              context.read<AuthBloc>().add(
                                    AuthEventRegister(
                                      email,
                                      password,
                                    ),
                                  );
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ),
                    ),
                    k10SizedBox,
                    TextButton(
                      onPressed: () {
                        if (!mounted) {
                          return;
                        }
                        context.read<AuthBloc>().add(
                              const AuthEventLogOut(),
                            );
                        // context.read<AuthBloc>().add(
                        //       const AuthEventShouldRegister(),
                        //     );
                      },
                      child: const Text(
                        'Already have an account? Log in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
