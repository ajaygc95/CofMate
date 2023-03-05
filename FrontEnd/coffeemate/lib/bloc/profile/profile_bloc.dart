import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:coffeemate/bloc/profile/profile_state.dart';
import 'package:coffeemate/constants/api.dart';
import 'package:coffeemate/models/Profile.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile profile = Profile();
  ProfileBloc() : super(InitialProfileState()) {
    on<UpdateProfileEvent>(onProfileCreate);
    on<AddImageEvent>(onAddImage);
    on<AddInterestsEvent>(onAddInterests);
    on<SubmitProfileEvent>(onSubmitProfile);
  }

  void onProfileCreate(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is UpdateProfileEvent) {
      if (event.label == "name") {
        print("${event.value}");
        profile = profile.copyWith(name: event.value);
      } else if (event.label == "dob") {
        profile =
            profile.copyWith(dob: DateFormat('MM/dd/yyyy').parse(event.value!));
      } else if (event.label == "firstName") {
        profile = profile.copyWith(firstName: event.value);
      } else if (event.label == "lastName") {
        profile = profile.copyWith(lastName: event.value);
      } else if (event.label == "bio") {
        profile = profile.copyWith(bio: event.value);
      } else if (event.label == "jobTitle") {
        profile = profile.copyWith(jobTitle: event.value);
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
    }
    emit(UpdateProfileState(profile: profile));
  }

  void onSubmitProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    print("Uploading profile");
    if (event is SubmitProfileEvent) {
      emit(UpdateProfileLoading());
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('token');
      print("Auth Token: ${authToken}");

      final profileJson = jsonEncode(profile);
      print("================== ProfileJson =========");
      print(profileJson);
      final response = await http.post(
        Uri.parse(profileApi),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: profileJson,
      );
      if (response.statusCode == 2000 || response.statusCode == 201) {
        print("============= Response from Proifle api ============");
        print("${response.body}");
      } else {
        print("${response.body}");
      }
    } catch (e) {
      print(e);
    }

    emit(ProfileUploaded());
  }
}
