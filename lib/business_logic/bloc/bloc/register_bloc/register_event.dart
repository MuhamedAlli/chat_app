part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  const RegisterUsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class RegisterPhoneChanged extends RegisterEvent {
  final String phone;
  const RegisterPhoneChanged(this.phone);
  @override
  List<Object> get props => [phone];
}

class RegisterSubmitted extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterCreatedUser extends RegisterEvent {
  @override
  List<Object> get props => [];
}
