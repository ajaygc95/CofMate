import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:coffeemate/bloc/profile/profile_state.dart';
import 'package:coffeemate/models/test_profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile profile = Profile();
  ProfileBloc() : super(InitialProfileState()) {
    on<UpdateProfileEvent>(onNumberIncrease);
    on<AddImageEvent>(onAddImage);
    on<AddInterestsEvent>(onAddInterests);
  }

  void onNumberIncrease(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is UpdateProfileEvent) {
      if (event.label == "name") {
        print("${event.value}");
        profile = profile.copyWith(name: event.value);
      } else if (event.label == "age") {
        profile = profile.copyWith(age: int.parse(event.value));
      } else if (event.label == "first_name") {
        profile = profile.copyWith(firstName: event.value);
      } else if (event.label == "last_name") {
        profile = profile.copyWith(lastName: event.value);
      } else if (event.label == "bio") {
        profile = profile.copyWith(bio: event.value);
      } else if (event.label == "jobTitle") {
        profile = profile.copyWith(jobTitle: event.value);
      } else if (event.label == "email") {
        profile = profile.copyWith(email: event.value);
      }
    }

    emit(UpdateProfileState(profile: profile));
  }

  void onAddImage(ProfileEvent event, Emitter<ProfileState> emit) {
    if (event is AddImageEvent) {
      print(" ========================= INSIDE +++++++++++++ ");
      final File? image = event.image;

      if (image != null) {
        emit(UpdateProfileLoading());

        profile = profile.copyWith(imageUrls: [...?profile.imageUrls, image]);
      }
    }
    print("I ma waiting for two seconds ++++++++ ");
    Future.delayed(Duration(seconds: 2));
    emit(UpdateProfileState(profile: profile));
  }

  void onAddInterests(ProfileEvent event, Emitter<ProfileState> emit) {
    if (event is AddInterestsEvent) {
      final String? interest = event.interest;

      if (interest != null) {
        emit(UpdateProfileLoading());

        profile = profile.copyWith(interests: [...profile.interests, interest]);
      }
      emit(UpdateProfileState(profile: profile));
    }
  }
}
