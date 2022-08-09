import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takenote/services/auth/auth_exceptions.dart';
import 'package:takenote/services/auth/auth_service.dart';
import 'package:takenote/services/auth/bloc/auth_bloc.dart';
import 'package:takenote/services/auth/bloc/auth_state.dart';
import 'package:takenote/utilities/dialogs/error_dialog.dart';

import '../constants/kConstants.dart';
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
        appBar: AppBar(
          title: const Text("Register"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: k8pad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Please register to your account to continue...',
                ),
              ),
              Padding(
                padding: k8pad,
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  showCursor: true,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      suffixIcon: IconButton(
                        onPressed: _email.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter your email here'),
                ),
              ),
              Padding(
                padding: k8pad,
                child: TextField(
                  obscureText: true,
                  showCursor: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffix: IconButton(
                        onPressed: _password.clear,
                        icon: const Icon(Icons.clear),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your password here'),
                  controller: _password,
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
                        //                 if (!mounted) {
                        //   return;
                        // }
                        // Navigator.of(context).pushNamed(verifyEmailRoute);
                        if (!mounted) {
                          return;
                        }
                        context.read<AuthBloc>().add(
                              AuthEventRegister(
                                email,
                                password,
                              ),
                            );
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: gradientButton.copyWith(
                          color: Colors.blue,
                          border: //copywith is used to override the border of the button
                              Border.all(
                            //Blue alpha border
                            color: Colors.blue.withAlpha(100),
                            width: 2,
                          ),
                          boxShadow: [
                            kBoxShadowBlue,
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Register',
                            style: kButtonTextStyle,
                          ),
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
