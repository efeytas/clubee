import 'dart:io';

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:clubbee/preferences.dart';
import 'package:clubbee/services/api_sevices.dart';
import 'package:clubbee/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:clubbee/views/profile/profile_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    final ImagePicker _picker = ImagePicker();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.photoUrl,
              onClicked: () async {
                showModalBottomSheet(
                    context: context,
                    elevation: 4,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text("Camera"),
                              onTap: () async {
                                XFile? file = await _picker.pickImage(
                                    source: ImageSource.camera);
                                if (file == null) {
                                  print("failed");
                                } else {
                                  ApiServices.uploadPhotoAsBytes(
                                      File(file.path));
                                }
                              },
                            ),
                            Container(
                              color: Colors.blueGrey,
                              height: 1,
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text("Photo Library"),
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            buildNameAndSurname(user),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            participatedEvents(),
            signOutButton()
          ],
        ),
      ),
    );
  }

  Widget participatedEvents() =>
      ButtonWidget(text: 'Participated Events', onClicked: () {});

  Widget signOutButton() => ButtonWidget(
      text: 'Sign Out',
      onClicked: () {
        AuthService().signOutCurrentUser();
      });

  Widget buildNameAndSurname(User user) => Column(
        children: [
          Text(
            user.fullName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget editProfile() => ButtonWidget(
        text: 'Edit Profile',
        onClicked: () {},
      );
}
