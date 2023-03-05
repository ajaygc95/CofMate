import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  const InputField({
    Key? key,
    required this.name,
    required this.controller,
    required this.formKey,
  }) : super(key: key);

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$name is required';
        }
        return null;
      },
    );
  }
}
