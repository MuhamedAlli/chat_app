import 'package:chat_app/business_logic/bloc/bloc/register_bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/routes_manager.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _logoWidget(),
              const SizedBox(
                height: 35,
              ),
              _usernameWidget(),
              _sizedBoxWidget(),
              _emailWidget(),
              _sizedBoxWidget(),
              _passwordWidget(),
              _sizedBoxWidget(),
              _phoneWidget(),
              _sizedBoxWidget(),
              _registerButton(context),
              _haveAnAccountButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoWidget() {
    return SizedBox(
      height: 120,
      width: 120,
      child: Image.asset("assets/images/chat.png"),
    );
  }

  Widget _usernameWidget() {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return TextField(
          onChanged: (username) {
            BlocProvider.of<RegisterBloc>(context)
                .add(RegisterUsernameChanged(username));
          },
          decoration: InputDecoration(
            hintText: "Username",
            errorText:
                BlocProvider.of<RegisterBloc>(context).isUsernameValid() != null
                    ? BlocProvider.of<RegisterBloc>(context).isUsernameValid()!
                        ? null
                        : "Invalid Username"
                    : null,
          ),
        );
      },
    );
  }

  Widget _emailWidget() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            BlocProvider.of<RegisterBloc>(context)
                .add(RegisterEmailChanged(email));
          },
          decoration: InputDecoration(
            hintText: "Email",
            errorText:
                BlocProvider.of<RegisterBloc>(context).isEmailValid() != null
                    ? BlocProvider.of<RegisterBloc>(context).isEmailValid()!
                        ? null
                        : "Invalid Email"
                    : null,
          ),
        );
      },
    );
  }

  Widget _passwordWidget() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            BlocProvider.of<RegisterBloc>(context)
                .add(RegisterPasswordChanged(password));
          },
          decoration: InputDecoration(
            hintText: "Password",
            errorText:
                BlocProvider.of<RegisterBloc>(context).isPasswordValid() != null
                    ? BlocProvider.of<RegisterBloc>(context).isPasswordValid()!
                        ? null
                        : "Invalid Password"
                    : null,
          ),
        );
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
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

  Widget _phoneWidget() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (phone) {
            BlocProvider.of<RegisterBloc>(context)
                .add(RegisterPhoneChanged(phone));
          },
          decoration: InputDecoration(
            hintText: "Phone",
            errorText:
                BlocProvider.of<RegisterBloc>(context).isPhoneValid() != null
                    ? BlocProvider.of<RegisterBloc>(context).isPhoneValid()!
                        ? null
                        : "Invalid Phone"
                    : null,
          ),
        );
      },
    );
  }

  Widget _registerButton(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          showLoaderDialog(context);
        }
        if (state is RegisterSuccessState) {
          Navigator.of(context).pushNamed(Routes.mainRoute);
        }else if (state is RegisterFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 4),
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed:
                BlocProvider.of<RegisterBloc>(context).isAllInputsValid() !=
                        null
                    ? BlocProvider.of<RegisterBloc>(context).isAllInputsValid()!
                        ? (() {
                            BlocProvider.of<RegisterBloc>(context)
                                .add(RegisterSubmitted());
                          })
                        : null
                    : null,
            child: const Text("Register"),
          ),
        );
      },
    );
  }

  Widget _haveAnAccountButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("have an account ?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.loginRoute);
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge))
      ],
    );
  }

  Widget _sizedBoxWidget() {
    return const SizedBox(
      height: 20,
    );
  }
}
