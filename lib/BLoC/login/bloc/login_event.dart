part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent({required this.email, required this.password});
}

class RegisterSubmitEvent extends LoginEvent {
  final String name; // Added name parameter
  final String email;
  final String password;

  RegisterSubmitEvent({required this.name, required this.email, required this.password});
}

class LoadProfileEvent extends LoginEvent {}

class LogoutEvent extends LoginEvent {}