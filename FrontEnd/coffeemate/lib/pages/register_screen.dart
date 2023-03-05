import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:coffeemate/pages/landing_screen.dart';
import 'package:coffeemate/pages/users_screen.dart';
import 'package:coffeemate/widgets/custom_button.dart';
import 'package:coffeemate/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String routename = '/registerscreen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final password2Controller = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                        "Enter Account Details",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      UsersScreen(),
                    ],
                  ),
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      _inputFields(name: "email"),
                      SizedBox(height: 20),
                      Text(
                        "username",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      _inputFields(name: "username"),
                      SizedBox(height: 20),
                      Text(
                        "phoneNumber",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      _inputFields(name: "phoneNumber"),
                      SizedBox(height: 20),
                      Text(
                        "password",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      _inputFields(name: "password"),
                      SizedBox(height: 20),
                      Text(
                        "password2",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 10),
                      _inputFields(name: "password2"),
                      SizedBox(height: 20),
                      _SubmitButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<RegisterBloc>(context).add(SubmitRegisterEvent());
              if (state is CompleteRegisterState) {
                Navigator.pushNamed(context, LandingScreen.routename);
              }
            },
            child: Text("Submit"),
          ),
        );
      },
    );
  }
}

class _inputFields extends StatelessWidget {
  final String name;
  const _inputFields({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: name == 'password' || name == 'password2',
      decoration: InputDecoration(
        labelText: name,
        hintText: "Enter your $name",
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(UpdateRegisterEvent(label: "$name", value: value));
      },
    );
  }
}
