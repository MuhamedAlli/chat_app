part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterUsernameChangeState extends RegisterState {
  final String username;
  const RegisterUsernameChangeState(this.username);
  @override
  List<Object> get props => [username];
}

class RegisterEmailChangeState extends RegisterState {
  final String email;
  const RegisterEmailChangeState(this.email);
  @override
  List<Object> get props => [email];
}

class RegisterPasswordChangeState extends RegisterState {
  final String password;
  const RegisterPasswordChangeState(this.password);
  @override
  List<Object> get props => [password];
}

class RegisterPhoneChangeState extends RegisterState {
  final String phone;
  const RegisterPhoneChangeState(this.phone);
  @override
  List<Object> get props => [phone];
}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final String error;
  const RegisterFailureState(this.error);
  @override
  List<Object> get props => [error];
}

class RegisterCreateUserSuccessState extends RegisterState {}

class RegisterCreateUserFailureState extends RegisterState {
  final String error;
  const RegisterCreateUserFailureState(this.error);
  @override
  List<Object> get props => [error];
}
