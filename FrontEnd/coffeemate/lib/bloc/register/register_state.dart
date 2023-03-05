part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {
  final Register register = Register();
}

class UpdateRegisterState extends RegisterState {
  final Register register;

  UpdateRegisterState({required this.register});
}

class CompleteRegisterState extends RegisterState {}

class RegisterError extends RegisterState {
  final String errorMessage;

  RegisterError({required this.errorMessage});
}
