import 'package:chat_app/data/models/models.dart';
import 'package:chat_app/shared_component/di.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared_component/preferences.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUsernameChanged>(_onRegisterUsernameChanged);
    on<RegisterEmailChanged>(_onRegisterEmailChanged);
    on<RegisterPasswordChanged>(_onRegisterPasswordChanged);
    on<RegisterPhoneChanged>(_onRegisterPhoneChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterCreatedUser>(_onRegisterCreatedUser);
  }
  String? username;
  String? email;
  String? password;
  String? phone;
  String? uId;
  void _onRegisterUsernameChanged(
      RegisterUsernameChanged event, Emitter<RegisterState> emit) {
    username = event.username;
    emit(RegisterUsernameChangeState(event.username));
  }

  void _onRegisterEmailChanged(
      RegisterEmailChanged event, Emitter<RegisterState> emit) {
    email = event.email;
    emit(RegisterEmailChangeState(event.email));
  }

  void _onRegisterPasswordChanged(
      RegisterPasswordChanged event, Emitter<RegisterState> emit) {
    password = event.password;
    emit(RegisterPasswordChangeState(event.password));
  }

  void _onRegisterPhoneChanged(
      RegisterPhoneChanged event, Emitter<RegisterState> emit) {
    phone = event.phone;
    emit(RegisterPhoneChangeState(event.phone));
  }

  AppPreferences appPreferences = instance();
  void _onRegisterSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      uId = userCredential.user!.uid;
      uidValue = uId;
      appPreferences.setUid(uidValue!);
      await createUser();
      emit(RegisterSuccessState());
    } catch (error) {
      //print("Error from try catch $error.toString()");
      emit(RegisterFailureState(error.toString()));
    }
  }

  bool isVerified = false;
  Future<void> createUser() async {
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (uId != null) {
      UserModel userModel = UserModel(
          username: username,
          email: email,
          phone: phone,
          uid: uId,
          image:
              "https://img.freepik.com/free-photo/smiley-little-boy-isolated-pink_23-2148984798.jpg",
          bio: "write your bio...",
          cover:
              "https://img.freepik.com/free-photo/pretty-little-girl-tulle-skirt-with-package-with-present-walking-isolated-pink-background-smiling-camera-cute-friendly-child-expressing-true-positive-emotions-place-text_197531-3557.jpg",
          isVerified: isVerified);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .set(userModel.toMap());
    }
  }

  void _onRegisterCreatedUser(
      RegisterCreatedUser event, Emitter<RegisterState> emit) {}
//function that handle the inputs of user!
  bool? isEmailValid() {
    if (email != null) {
      return RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email!);
    }

    return null;
  }

  bool? isUsernameValid() {
    if (username != null) {
      return username!.length >= 8;
    }
    return null;
  }

  bool? isPhoneValid() {
    if (phone != null) {
      return phone!.length >= 11;
    }
    return null;
  }

  bool? isPasswordValid() {
    if (password != null) {
      return password!.length >= 6;
    }
    return null;
  }

  bool? isAllInputsValid() {
    if (isEmailValid() != null &&
        isPasswordValid() != null &&
        isUsernameValid() != null &&
        isPhoneValid() != null) {
      return isEmailValid()! &&
          isPasswordValid()! &&
          isUsernameValid()! &&
          isPhoneValid()!;
    }
    return null;
  }
}
