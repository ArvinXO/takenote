import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/components/background_blue.dart';
import 'package:takenote/services/auth/auth_exceptions.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';

import '../constants/k_constants.dart';
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
    Size sizeQuery = MediaQuery.of(context).size;

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
        body: BlueBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeQuery.height * 0.12,
              ),
              Hero(
                tag: "logo",
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: sizeQuery.width * 0.30,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                  horizontal: sizeQuery.width * 0.07,
                  vertical: sizeQuery.height * 0.01,
                ),
                child: const Text(
                  'REGISTER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: sizeQuery.height * 0.01),
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
              Center(
                child: Column(
                  children: [
                    TextButton(
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
                      child: kRegisterContainer,
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
                      child: const Text('Back to login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
