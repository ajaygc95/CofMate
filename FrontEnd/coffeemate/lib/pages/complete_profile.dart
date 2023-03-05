import 'package:coffeemate/widgets/complete_profile_widget_from.dart';
import 'package:coffeemate/widgets/profile_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CompleteProfile extends StatelessWidget {
  static const String routename = '/completeprofilescreen';
  final String token;
  const CompleteProfile({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/userprofilescreen');
            },
            child: Icon(LineAwesomeIcons.angle_left),
          ),
          title: Text("Complete your Profile"),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userprofilescreen');
              },
              icon: Icon(LineAwesomeIcons.user),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: CompleteProfileForm(),
        ));
  }
}
