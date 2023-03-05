import 'dart:io';

import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:coffeemate/bloc/register/register_bloc.dart';
import 'package:coffeemate/models/Profile.dart';
import 'package:coffeemate/widgets/profile_picture_form.dart';
import 'package:flutter/material.dart';
import 'package:coffeemate/widgets/profile_input_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Profile _profile = Profile();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              "Please complete your profile",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 24),
            ProfileInputField(name: "firstName", formKey: _formKey),
            SizedBox(height: 16),
            ProfileInputField(name: "lastName", formKey: _formKey),
            SizedBox(height: 16),
            ProfileInputField(name: "jobTitle", formKey: _formKey),
            SizedBox(height: 16),
            ProfileInputField(name: "bio", formKey: _formKey),
            SizedBox(height: 16),
            ProfileInputField(
                name: "dob",
                formKey: _formKey,
                keyboardType: TextInputType.datetime),
            const SizedBox(height: 24),
            ProfilePictureField(
              name: 'Add at leat 2 pictures',
              formKey: _formKey,
              onImagesSelected: (List<File> images) {
                // TODO: implement API upload logic
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  print("Submite Clicked");
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<ProfileBloc>(context)
                        .add(SubmitProfileEvent());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
