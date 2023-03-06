import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String email;
  final String password;
  final String password2;
  final String username;
  final String phoneNumber;

  Register({
    this.email = '',
    this.password = '',
    this.password2 = '',
    this.username = '',
    this.phoneNumber = '',
  });

  @override
  List<Object?> get props =>
      [email, password, password2, username, phoneNumber];

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required.';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long.';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    final phoneRegex = RegExp(
      r'^\+?\d{10,15}$',
    );

    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    return null;
  }

  String? validatePassword2(String? value, String? password1) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }

    if (password1 != value) {
      return 'Passwords do not match.';
    }

    return null;
  }

  Register copyWith({
    String? email,
    String? password,
    String? password2,
    String? username,
    String? phoneNumber,
  }) {
    return Register(
      email: email ?? this.email,
      password: password ?? this.password,
      password2: password2 ?? this.password2,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password2': password2,
      'username': username,
      'phone_number': phoneNumber,
    };
  }
}
