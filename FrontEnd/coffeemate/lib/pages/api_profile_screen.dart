import 'package:coffeemate/bloc/profile/profile_bloc.dart';
import 'package:coffeemate/bloc/profile/profile_event.dart';
import 'package:coffeemate/bloc/profile/profile_state.dart';
import 'package:coffeemate/constants/api.dart';
import 'package:coffeemate/widgets/custom_text_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProfileScreen extends StatefulWidget {
  static const String routename = '/apiprofileScreen';

  const ApiProfileScreen({super.key});

  @override
  _ApiProfileScreenState createState() => _ApiProfileScreenState();
}

class _ApiProfileScreenState extends State<ApiProfileScreen> {
  var _profile = {};
  bool _isLoading = true;
  List<dynamic> imageUrls = [];
  var _token;

  @override
  initState() {
    super.initState();
    _fetchProfile();
  }

  _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });

    // var response = await http.get(Uri.parse(profileApi),
    //     headers: {"Authorization": "Bearer " + _token});
    // var jsonData = json.decode(response.body);

    BlocProvider.of<ProfileBloc>(context).add(GetProfileFromApi());

    // setState(() {
    //   _isLoading = false;
    //   _profile = jsonData;
    //   imageUrls = jsonData['images'];
    //   print("[INFO] this is first iamge URLS: ${imageUrls[0]['image']}");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 62, 18, 18)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: Color.fromARGB(255, 60, 54, 52),
            ),
            color: Colors.black87,
          )
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileFromApiState) {
          _isLoading = false;
          _profile = state.profile;
          imageUrls = state.profile['images'];
          print("[INFO] this is first iamge URLS: ${imageUrls[0]['image']}");
        }
        return _isLoading
            ? Center(child: CircularProgressIndicator())
            : _profile.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(3, 3),
                                      blurRadius: 3,
                                      spreadRadius: 3),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    imageUrls[0]['image'],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(0, 0, 0, 0),
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _profile['first_name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _profile['last_name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleWithIcon(
                                  title: 'Biography', icon: Icons.edit),
                              Text(
                                "Lorem Es un hecho establecido hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño. El punto de usar Lorem Ipsum es que tiene una distribución más o menos normal de las letras",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              TitleWithIcon(
                                  title: 'Pictures', icon: Icons.edit),
                              SizedBox(
                                height: 125,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 125,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  imageUrls[index]['image']),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              TitleWithIcon(
                                  title: 'Location', icon: Icons.edit),
                              Text(
                                "Sunnyvale , Ca",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              TitleWithIcon(
                                  title: 'Interest', icon: Icons.edit),
                              Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  CustomTextContainer(text: "Not Babysitting"),
                                  CustomTextContainer(text: "Dance "),
                                  CustomTextContainer(text: "Doing AJ"),
                                  CustomTextContainer(text: "Coffee"),
                                  CustomTextContainer(
                                      text: "Celebrity Gossips"),
                                  CustomTextContainer(text: "Movies"),
                                  CustomTextContainer(text: "Soccer"),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Text("No profile data found"),
                  );
      }),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.edit))
      ],
    );
  }
}
