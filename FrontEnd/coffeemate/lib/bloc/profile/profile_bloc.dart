import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:coffeemate/bloc/profile/profile_state.dart';
import 'package:coffeemate/constants/api.dart';
import 'package:coffeemate/models/Profile.dart';
import 'package:coffeemate/repositories/auth_repository.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile profile = Profile();
  final AuthRepository _authRepository = AuthRepository();
  ProfileBloc() : super(InitialProfileState()) {
    on<UpdateProfileEvent>(onProfileUpdate);
    on<AddImageEvent>(onAddImage);
    on<AddInterestsEvent>(onAddInterests);
    on<SubmitProfileEvent>(onSubmitProfile);
    on<GetProfileFromApi>(onGetProfile);
  }

  void onProfileUpdate(ProfileEvent event, Emitter<ProfileState> emit) async {
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
      final File? image = event.image;

      if (image != null) {
        emit(UpdateProfileLoading());
        profile = profile.copyWith(imageUrls: [...?profile.imageUrls, image]);
      }
    }
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
    if (event is SubmitProfileEvent) {
      emit(UpdateProfileLoading());
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('token');
      final profileJson = jsonEncode(profile);
      final response = await http.post(
        Uri.parse(profileApi),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: profileJson,
      );
      if (response.statusCode == 2000 || response.statusCode == 201) {
      } else {
        print("${response.body}");
      }
    } catch (e) {
      print(e);
    }

    emit(ProfileUploaded());
  }

  void onGetProfile(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is GetProfileFromApi) {
      final sharedPrefs = await SharedPreferences.getInstance();
      final token = sharedPrefs.getString('token');
      final profileJson = await _authRepository.getProfile(token!);
      final profile = json.decode(profileJson) as Map<String, dynamic>;
      emit(ProfileFromApiState(profile: profile));
    }
  }
}
