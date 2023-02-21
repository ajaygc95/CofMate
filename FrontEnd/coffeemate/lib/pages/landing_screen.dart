import 'package:coffeemate/bloc/login/login_bloc.dart';
import 'package:coffeemate/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatelessWidget {
  static const String routename = '/landingscreen';
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  _getUserIdFromSharedPrefs(context);
                } else {
                  return LoginForm();
                }

                return LoginForm();
              },
            ),
          ),
        ),
      ),
    );
  }

  void _getUserIdFromSharedPrefs(BuildContext context) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final token = sharedPrefs.getString('token');

    Navigator.of(context).pushNamed('/userscreen', arguments: token);
  }
}
