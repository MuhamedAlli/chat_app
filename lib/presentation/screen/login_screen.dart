// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/bloc/login_bloc/login_bloc.dart';
import '../resources/routes_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLogading) {
            showLoaderDialog(context, "Loading...");
          } else if (state is LoginFailureState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 5),
                content: Text(state.error),
              ),
            );
          } else if (state is LoginSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
          }
        },
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 200,
                ),
                const _LogoWidget(),
                const SizedBox(
                  height: 40,
                ),
                _UsernameInputWidget(),
                const SizedBox(
                  height: 20,
                ),
                _PasswordInputWidget(),
                const SizedBox(
                  height: 30,
                ),
                const _LoginButtonWidget(),
                Align(
                    alignment: Alignment.center,
                    child: _registerButton(context)),
              ]),
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account ?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.registerRoute);
            },
            child: Text("Register",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge))
      ],
    );
  }

  showLoaderDialog(BuildContext context, String mes) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: Text(mes)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.asset("assets/images/chat.png"),
    );
  }
}

class _UsernameInputWidget extends StatelessWidget {
  _UsernameInputWidget();

  String? username;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginUsernameChangeState) {
          username = state.username;
        }
      },
      builder: ((context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          decoration: InputDecoration(
            hintText: 'Email',
            errorText: username != null
                ? username!.isEmpty
                    ? "invalid Email"
                    : null
                : username,
          ),
          onChanged: (username) {
            BlocProvider.of<LoginBloc>(context)
                .add(LoginUsernameChanged(username));
          },
        );
      }),
    );
  }
}

class _PasswordInputWidget extends StatelessWidget {
  _PasswordInputWidget();
  String? password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginPasswordChangeState) {
          password = state.password;
        }
      },
      builder: ((context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          decoration: InputDecoration(
            hintText: 'Password',
            errorText: password != null
                ? password!.isEmpty
                    ? "invalid password"
                    : null
                : password,
          ),
          onChanged: (password) {
            BlocProvider.of<LoginBloc>(context)
                .add(LoginPasswordChanged(password));
          },
        );
      }),
    );
  }
}

class _LoginButtonWidget extends StatelessWidget {
  const _LoginButtonWidget();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            onPressed: BlocProvider.of<LoginBloc>(context).isValid()
                ? (() {
                    BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());
                  })
                : null,
            child: const Text('Login'),
          ),
        );
      },
    );
  }
}
