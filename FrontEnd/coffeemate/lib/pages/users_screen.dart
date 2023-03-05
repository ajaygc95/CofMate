import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  static const String routename = "/userscreen";
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterInitial) {
            return Column(
              children: [Text(" Email: ${state.register.email}")],
            );
          } else if (state is UpdateRegisterState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: ${state.register.email}"),
                Text("Username: ${state.register.username}"),
                Text("password: ${state.register.password}"),
                Text("password2: ${state.register.password2}"),
                Text("phoneNumber: ${state.register.phoneNumber}"),
              ],
            );
          }
          return Text("Something Went Wrong");
        },
      ),
    );
  }
}
