part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterEvent({required this.name, required this.email, required this.password});
}
class ResetEvent extends AuthEvent {
  final String email;

  ResetEvent({required this.email});
}