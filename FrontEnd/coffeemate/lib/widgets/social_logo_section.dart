import 'package:coffeemate/widgets/social_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLogoSection extends StatelessWidget {
  const SocialLogoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
