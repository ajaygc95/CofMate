import 'package:coffeemate/bloc/login/login_bloc.dart';
import 'package:coffeemate/widgets/custom_button.dart';
import 'package:coffeemate/widgets/divider_widget.dart';
import 'package:coffeemate/widgets/input_field.dart';
import 'package:coffeemate/widgets/social_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sp",
                style: Theme.of(context).textTheme.headline1,
              ),
              ShaderMask(
                shaderCallback: (bounds) => RadialGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    const Color.fromARGB(255, 80, 244, 54)
                  ],
                  center: Alignment.center,
                  radius: 1.0,
                ).createShader(bounds),
                child: const Icon(
                  Icons.gps_fixed_sharp,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Text(
                "t",
                style: Theme.of(context).textTheme.headline1!,
              ),
              Text(
                "Mate",
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          const SizedBox(height: 40),
          InputField(
            name: 'username',
            controller: usernameController,
          ),
          const SizedBox(height: 15),
          InputField(
            name: 'password',
            controller: passwordController,
          ),
          const SizedBox(height: 15),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Not a member? "),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/registerscreen');
                },
                child: const Text(
                  "Register Now",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(
                LoginButtonPressed(
                  username: usernameController.text,
                  password: passwordController.text,
                ),
              );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SocialLogo(
                icon: FontAwesomeIcons.google,
                color: Color(0xFFDB4437),
              ),
              SizedBox(
                width: 40,
              ),
              SocialLogo(
                icon: FontAwesomeIcons.facebook,
                color: Color(0xFF3B5998),
              ),
              SizedBox(
                width: 40,
              ),
              SocialLogo(
                icon: FontAwesomeIcons.apple,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
