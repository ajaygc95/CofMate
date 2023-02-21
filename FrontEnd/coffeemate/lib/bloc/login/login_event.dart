part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({required super.username, required super.password});
}
