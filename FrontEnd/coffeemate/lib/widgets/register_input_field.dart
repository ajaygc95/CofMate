import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputField extends StatelessWidget {
  final String name;
  final TextEditingController controller;

  const InputField({Key? key, required this.name, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: name == 'password' || name == 'password2',
      decoration: InputDecoration(
        labelText: name,
        hintText: "Enter your $name",
        hintStyle: TextStyle(color: Colors.grey[500]),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      onChanged: (value) {
        BlocProvider.of<RegisterBloc>(context)
            .add(UpdateRegisterEvent(label: "$name", value: value));
      },
      validator: (value) => null,
    );
  }
}
