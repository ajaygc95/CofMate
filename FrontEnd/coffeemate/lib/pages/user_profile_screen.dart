import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routename = '/userprofilescreen';
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is UpdateProfileState) {
              final profile = state.profile;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${profile.firstName} ${profile.lastName}'),
                    Text('Age: ${profile.age ?? "N/A"}'),
                    Text('Job Title: ${profile.jobTitle}'),
                    Text('Bio: ${profile.bio}'),
                    // Show profile pictures here
                    Text('Photos:', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: profile.imageUrls?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              3, // number of images to display in one row
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(profile.imageUrls![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
