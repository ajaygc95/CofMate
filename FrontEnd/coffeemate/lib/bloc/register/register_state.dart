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

class SubmittingRegisterState extends RegisterState {}
