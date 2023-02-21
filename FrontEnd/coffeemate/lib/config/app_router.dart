import 'package:coffeemate/pages/landing_screen.dart';
import 'package:coffeemate/pages/register_screen.dart';
import 'package:coffeemate/pages/users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingScreen.routename:
        return MaterialPageRoute(builder: (context) => LandingScreen());
      case UsersScreen.routename:
        return MaterialPageRoute(builder: (context) => UsersScreen());
      case RegisterScreen.routename:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ERROR'),
        centerTitle: true,
      ),
      body: Center(child: Text('Page not found')),
    );
  });
}
