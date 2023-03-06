import 'package:coffeemate/bloc/login/login_bloc.dart';
import 'package:coffeemate/pages/api_profile_screen.dart';
import 'package:coffeemate/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
                if (state is LoginLoading) {
                  return const CircularProgressIndicator(); // Show loading indicator
                } else if (state is LoginSuccess) {
                  if (state.hasProfile) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed(
                          ApiProfileScreen.routename,
                          arguments: state.token);
                    });
                  } else {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/completeprofilescreen',
                          arguments: state.token);
                    });
                    // Navigator.of(context)
                    //     .pushNamed('/completeprofilescreen',
                    //         arguments: state.token)
                    //     .then((value) {
                    //   // Do something after the navigation is complete
                    // });
                  }
                } else {
                  return LoginForm();
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  // void _getUserIdFromSharedPrefs(BuildContext context) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final token = sharedPrefs.getString('token');

  //   // ignore: use_build_context_synchronously
  //   Navigator.of(context).pushNamed('/userscreen', arguments: token);
  // }
}
