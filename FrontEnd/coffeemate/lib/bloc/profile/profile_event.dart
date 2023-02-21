import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String label;
  final dynamic value;

  UpdateProfileEvent({required this.label, required this.value});
}

class AddImageEvent extends ProfileEvent {
  final File? image;
  AddImageEvent({required this.image});
}

class AddInterestsEvent extends ProfileEvent {
  final String interest;

  AddInterestsEvent({required this.interest});
}
