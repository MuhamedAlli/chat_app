import 'package:chat_app/shared_component/preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared_component/di.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }
  AppPreferences appPreferences = instance();
  String username = "";
  String password = "";
  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    username = event.username;
    emit(LoginUsernameChangeState(event.username));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    password = event.password;
    emit(LoginPasswordChangeState(event.password));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLogading());
    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: username, password: password);
        if (userCredential.user != null) {
          appPreferences.setUid(userCredential.user!.uid);
          uidValue = userCredential.user!.uid;
        }
        //print(userCredential.user!.uid);
        emit(LoginSuccessState());
      } catch (error) {
        //print("Error ${error.toString()}");
        emit(LoginFailureState(error.toString()));
      }
    }
  }

  bool isValid() {
    if (username.isNotEmpty && password.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
