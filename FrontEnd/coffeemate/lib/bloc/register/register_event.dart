part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class UpdateRegisterEvent extends RegisterEvent {
  final String label;
  final dynamic value;

  UpdateRegisterEvent({required this.label, required this.value});
}

class SubmitRegisterEvent extends RegisterEvent {}
