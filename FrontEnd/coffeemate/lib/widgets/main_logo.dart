import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
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
    );
  }
}
