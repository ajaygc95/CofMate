import 'dart:async';

import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:coffeemate/pages/landing_screen.dart';
import 'package:coffeemate/pages/users_screen.dart';
import 'package:coffeemate/widgets/custom_button.dart';
import 'package:coffeemate/widgets/input_field.dart';
import 'package:coffeemate/widgets/register_input_field_and_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String routename = '/registerscreen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: RegisterForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                  colors: [Theme.of(context).primaryColor, Colors.red],
                  center: Alignment.center,
                  radius: 1.0,
                ).createShader(bounds),
                child: const Icon(
                  Icons.person_pin_circle_rounded,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              Text(
                "Enter your account details",
                style: Theme.of(context).textTheme.headline2,
              ),
              const UsersScreen(),
            ],
          ),
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              RegisterInputField(
                name: "email",
                formKey: _formKey,
              ),
              const SizedBox(height: 20),
              Text(
                "username",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              RegisterInputField(
                name: "username",
                formKey: _formKey,
              ),
              const SizedBox(height: 20),
              Text(
                "phoneNumber",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              RegisterInputField(
                name: "phoneNumber",
                formKey: _formKey,
              ),
              const SizedBox(height: 20),
              Text(
                "password",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              RegisterInputField(
                name: "password",
                formKey: _formKey,
              ),
              const SizedBox(height: 20),
              Text(
                "password2",
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              RegisterInputField(
                name: "password2",
                formKey: _formKey,
              ),
              const SizedBox(height: 20),
              _SubmitButton(
                formKey: _formKey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const _SubmitButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is SubmitRegisterEvent) {
          return const CircularProgressIndicator();
        } else {
          return Center(
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  print("Submite Clicked");
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<RegisterBloc>(context)
                        .add(SubmitRegisterEvent());
                    if (state is CompleteRegisterState) {
                      Navigator.pushNamed(context, LandingScreen.routename);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is CompleteRegisterState) {
          const snackBar =
              SnackBar(content: Text("Your account has been registered!"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Timer(const Duration(seconds: 2), () {
            Navigator.pushNamed(context, LandingScreen.routename);
          });
        }
      },
    );
  }
}
