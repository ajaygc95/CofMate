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

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email'],
      username: json['username'],
      password: json['password'],
      password2: json['password2'],
      phoneNumber: json['phoneNumber'],
    );
  }

  @override
  List<Object?> get props =>
      [email, password, password2, username, phoneNumber];

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
}
