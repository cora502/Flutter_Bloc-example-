part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class RegisterSuccess extends LoginState {}

final class ProfileLoaded extends LoginState {
  final String name;
  final String email;
  
  ProfileLoaded({required this.name, required this.email});
}

final class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}