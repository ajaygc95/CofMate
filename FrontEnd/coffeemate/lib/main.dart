import 'package:coffeemate/bloc/login/login_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:coffeemate/config/app_router.dart';
import 'package:coffeemate/config/custom_theme.dart';
import 'package:coffeemate/pages/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: MaterialApp(
        theme: theme(),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: LandingScreen.routename,
      ),
    );
  }
}
