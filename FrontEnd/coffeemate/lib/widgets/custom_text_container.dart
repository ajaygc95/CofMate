import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:coffeemate/bloc/profile/profile_state.dart';

class CustomTextContainer extends StatelessWidget {
  final String text;
  const CustomTextContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<ProfileBloc>(context)
                .add(AddInterestsEvent(interest: text));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 5),
            child: Container(
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Color.fromARGB(255, 83, 170, 240),
                  ],
                ),
              ),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white, height: 1.8),
              ),
            ),
          ),
        );
      },
    );
  }
}
