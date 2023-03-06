import 'dart:io';
import 'package:coffeemate/models/Profile.dart';

class ProfileState {}

class InitialProfileState extends ProfileState {
  final Profile profile = Profile();
}

class UpdateProfileState extends ProfileState {
  final Profile profile;

  UpdateProfileState({required this.profile});
}

class UpdateProfileLoading extends ProfileState {}

class ProfileUploaded extends ProfileState {}

class ProfileFromApiState extends ProfileState {
  final Map<String, dynamic> profile;

  ProfileFromApiState({required this.profile});
}


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
