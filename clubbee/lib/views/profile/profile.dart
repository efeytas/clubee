import 'dart:io';
import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/services/api_sevices.dart';
import 'package:clubbee/services/auth_services.dart';
import 'package:clubbee/views/profile/participated_events.dart';
import 'package:clubbee/widgets/single_chapter_page.dart';
import 'package:flutter/material.dart';
import 'package:clubbee/views/profile/profile_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user.dart';

XFile? file;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = currentUser;
    final ImagePicker picker = ImagePicker();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: file?.path ?? "",
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
                                Navigator.pop(context);
                                var new_file = await picker.pickImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  file = new_file;
                                });
                                if (file == null) {
                                  print("failed");
                                }
                              },
                            ),
                            Container(
                              color: Colors.blueGrey,
                              height: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text("Photo Library"),
                              onTap: () async {
                                Navigator.pop(context);
                                var new_file = await picker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  file = new_file;
                                });
                                if (file == null) {
                                  print("failed");
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            const SizedBox(height: 24),
            buildNameAndSurname(user!),
            const SizedBox(height: 24),
            //NumbersWidget(),
            const SizedBox(height: 24),
            buildAbout(user),
            const SizedBox(height: 10),
            participatedEvents(),
            const SizedBox(height: 8),
            signOutButton()
          ],
        ),
      ),
    );
  }

  Widget participatedEvents() => ButtonWidget(
      text: 'Participated Events',
      onClicked: () {
        Get.to(() => ParticipatedEventsPage());
      });

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

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Active Chapters',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 270,
              child: ListView.builder(
                itemCount: activeChapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        title: Text(
                          activeChapters[index][0],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
}
