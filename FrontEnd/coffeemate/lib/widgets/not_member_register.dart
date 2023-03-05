import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotMemeberRegister extends StatelessWidget {
  const NotMemeberRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Not a member? "),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/registerscreen');
          },
          child: const Text(
            "Register Now",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
