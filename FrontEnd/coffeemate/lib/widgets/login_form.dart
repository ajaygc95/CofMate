import 'package:coffeemate/bloc/login/login_bloc.dart';
import 'package:coffeemate/widgets/custom_button.dart';
import 'package:coffeemate/widgets/divider_widget.dart';
import 'package:coffeemate/widgets/error_message_section.dart';
import 'package:coffeemate/widgets/input_field.dart';
import 'package:coffeemate/widgets/main_logo.dart';
import 'package:coffeemate/widgets/not_member_register.dart';
import 'package:coffeemate/widgets/social_logo_section.dart';
import 'package:coffeemate/widgets/upper_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          setState(() {
            _errorMessage = 'Username and password didn\'t match';
          });
        } else {
          setState(() {
            _errorMessage = null;
          });
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainLogo(),
                UpperLogo(),
                const SizedBox(height: 40),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 15),
                  ErrorMessageSection(errorMessage: _errorMessage)
                ],
                SizedBox(height: 10),
                InputField(
                  name: 'username',
                  controller: usernameController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 15),
                InputField(
                  name: 'password',
                  controller: passwordController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 10),
                NotMemeberRegister(),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    print("Sign In Pressed");
                    setState(() {
                      _errorMessage = null;
                    });
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginButtonPressed(
                          username: usernameController.text,
                          password: passwordController.text,
                        ),
                      );
                    }
                  },
                  child: CustomButton(
                    text: "Sign In",
                    usernameController: usernameController,
                    passwordController: passwordController,
                  ),
                ),
                const SizedBox(height: 70),
                const DividerWidget(),
                const SizedBox(height: 20),
                SocialLogoSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
