part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLogading extends LoginState {}

class LoginUsernameChangeState extends LoginState {
  final String username;
  LoginUsernameChangeState(this.username);
  @override
  List<Object> get props => [username];
}

class LoginPasswordChangeState extends LoginState {
  final String password;
  LoginPasswordChangeState(this.password);
  @override
  List<Object> get props => [password];
}

class LoginSuccessState extends LoginState {
  //final String userId;
  LoginSuccessState();
  @override
  List<Object> get props => [];
}

class LoginFailureState extends LoginState {
  final String error;
  LoginFailureState(this.error);
  @override
  List<Object> get props => [error];
}
