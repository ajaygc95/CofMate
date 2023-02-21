import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialLogo extends StatelessWidget {
  final Color color;
  final IconData icon;
  const SocialLogo({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Icon(
        icon,
        size: 50,
        color: color,
      ),
    );
  }
}
