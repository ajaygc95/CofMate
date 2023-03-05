import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpperLogo extends StatelessWidget {
  const UpperLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sp",
          style: Theme.of(context).textTheme.headline1,
        ),
        ShaderMask(
          shaderCallback: (bounds) => RadialGradient(
            colors: [
              Theme.of(context).primaryColor,
              const Color.fromARGB(255, 80, 244, 54)
            ],
            center: Alignment.center,
            radius: 1.0,
          ).createShader(bounds),
          child: const Icon(
            Icons.gps_fixed_sharp,
            size: 40,
            color: Colors.white,
          ),
        ),
        Text(
          "t",
          style: Theme.of(context).textTheme.headline1!,
        ),
        Text(
          "Mate",
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
