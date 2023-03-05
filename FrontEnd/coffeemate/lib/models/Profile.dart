import 'dart:io';

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  String email;
  String name;
  DateTime? dob;
  String firstName;
  String lastName;
  String jobTitle;
  String bio;
  List<File>? imageUrls;
  List interests;

  Profile({
    this.email = '',
    this.name = '',
    this.dob,
    this.firstName = '',
    this.lastName = '',
    this.jobTitle = '',
    this.bio = '',
    this.imageUrls = const [],
    this.interests = const [],
  });

  @override
  List<Object?> get props =>
      [email, name, dob, firstName, lastName, jobTitle, bio, imageUrls];
  Map<String, dynamic> toJson() {
    List<String> imageUrls =
        this.imageUrls?.map((file) => file.path).toList() ?? [];
    List<String> interests =
        this.interests.map((interest) => interest.toString()).toList();

    return {
      'dob': this.dob?.toString(),
      'first_name': this.firstName,
      'last_name': this.lastName,
      'job_title': this.jobTitle,
      'bio': this.bio,
      'images': imageUrls,
      'interests': interests,
      'is_completed': true,
    };
  }

  Profile copyWith({
    String? email,
    String? name,
    DateTime? dob,
    String? firstName,
    String? bio,
    String? lastName,
    String? jobTitle,
    List<File>? imageUrls,
    List? interests,
  }) {
    return Profile(
      email: email ?? this.email,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      bio: bio ?? this.bio,
      firstName: firstName ?? this.firstName,
      imageUrls: imageUrls ?? this.imageUrls,
      jobTitle: jobTitle ?? this.jobTitle,
      lastName: lastName ?? this.lastName,
      interests: interests ?? this.interests,
    );
  }

  int? get age {
    if (dob != null) {
      final now = DateTime.now();
      final age = now.year - dob!.year;
      if (now.month < dob!.month ||
          (now.month == dob!.month && now.day < dob!.day)) {
        return age - 1;
      }
      return age;
    }
    return null;
  }
}
