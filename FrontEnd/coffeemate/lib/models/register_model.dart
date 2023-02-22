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
