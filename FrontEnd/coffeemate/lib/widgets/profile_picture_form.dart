import 'dart:io';

import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureField extends StatefulWidget {
  final String name;
  final GlobalKey<FormState> formKey;
  final Function(List<File>)? onImagesSelected;

  const ProfilePictureField({
    Key? key,
    required this.name,
    required this.formKey,
    this.onImagesSelected,
  }) : super(key: key);

  @override
  _ProfilePictureFieldState createState() => _ProfilePictureFieldState();
}

class _ProfilePictureFieldState extends State<ProfilePictureField> {
  List<File> _images = [];
  File? _imageFile;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
        _imageFile = File(pickedFile.path);
      });

      if (widget.onImagesSelected != null) {}

      BlocProvider.of<ProfileBloc>(context)
          .add(AddImageEvent(image: _imageFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _images.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index < _images.length) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  image: DecorationImage(
                    image: FileImage(_images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: _getImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, color: Colors.grey.shade400),
                      const SizedBox(height: 4),
                      Text('Add Image',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade400)),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
