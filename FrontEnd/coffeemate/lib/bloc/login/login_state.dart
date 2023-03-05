part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});
}

class LoginSuccess extends LoginState {
  final String token;
  final bool hasProfile;

  LoginSuccess({required this.token, this.hasProfile = false});

  @override
  List<Object> get props => [token, hasProfile];
}
