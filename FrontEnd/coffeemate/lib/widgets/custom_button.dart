import 'package:coffeemate/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const CustomButton(
      {super.key,
      required this.text,
      required this.usernameController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black),
      child: Container(
        height: 55,
        width: double.infinity,
        child: Center(
          child: Text(
            "${text}",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
