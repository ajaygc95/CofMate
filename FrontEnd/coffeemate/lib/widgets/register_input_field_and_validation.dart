import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:coffeemate/models/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterInputField extends StatelessWidget {
  final String name;
  final GlobalKey<FormState> formKey;
  const RegisterInputField({
    Key? key,
    required this.name,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: (value) {
        final register = (BlocProvider.of<RegisterBloc>(context).state
                as UpdateRegisterState)
            .register;
        switch (name) {
          case 'email':
            return register.validateEmail(value);
          case 'username':
            return register.validateUsername(value);
          case 'phoneNumber':
            return register.validatePhoneNumber(value);
          case 'password':
            return register.validatePassword(value);
          case 'password2':
            return register.validatePassword2(value, register.password);
          default:
            return null;
        }
      },
     
    );
  }
}
