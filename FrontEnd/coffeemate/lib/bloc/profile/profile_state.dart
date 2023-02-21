import 'dart:io';
import 'package:coffeemate/models/test_profile.dart';

class ProfileState {}

class InitialProfileState extends ProfileState {
  final Profile profile = Profile();
}

class UpdateProfileState extends ProfileState {
  final Profile profile;

  UpdateProfileState({required this.profile});
}

class UpdateProfileLoading extends ProfileState {}



// class UpdateProfileState {
//   final String name;

//   UpdateProfileState({required this.name});

//   ProfileState update(ProfileState currentState) {
//     return ProfileState(
//       name: name,
//       age: currentState.age,
//     );
//   }
// }
