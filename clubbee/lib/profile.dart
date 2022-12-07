import 'package:clubbee/preferences.dart';
import 'package:flutter/material.dart';
import 'package:clubbee/profile_widget.dart';
import 'package:clubbee/demo_values.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildNameAndSurname(user),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 24),
          Center(child: editProfile()),
          const SizedBox(height: 48),
          buildAbout(user),
          participatedEvents(),
          likedEvents(),
          notificationSettings(),
          languageSettings(),
          signOutButton()
        ],
      ),
    );
  }

  Widget participatedEvents() =>
      ButtonWidget(text: 'Participated Events', onClicked: () {});

  Widget likedEvents() => ButtonWidget(text: 'Liked Events', onClicked: () {});

  Widget notificationSettings() =>
      ButtonWidget(text: 'Notification Settings', onClicked: () {});

  Widget languageSettings() =>
      ButtonWidget(text: 'Language Settings', onClicked: () {});

  Widget signOutButton() => ButtonWidget(text: 'Sign Out', onClicked: () {});

  Widget buildNameAndSurname(User user) => Column(
        children: [
          Text(
            user.name + " " + user.surname,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student ID Buraya başka bişi yapcm',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.studentID,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
