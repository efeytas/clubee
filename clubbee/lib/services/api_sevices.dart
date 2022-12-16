import 'dart:io';
import 'package:clubbee/models/chapter.dart';
import 'package:clubbee/models/user.dart';
import 'package:clubbee/preferences.dart';
import 'package:http/http.dart' as http;

import 'package:clubbee/models/event.dart';

class ApiServices {
  static uploadPhotoAsBytes(File photo) {}

  static Future<bool> joinEvent(Event event) async {
    //var response = http.post(Uri.parse("efe.com/event/join"), body: {"eventID": 1232});
    return true;
    // return http status code 200 on successful join
  }

  static Future<User> getUserData(int userId) async {
    // var response = http.get(Uri.parse("efe.com/user/get/070220762"));
    return User(
        id: userId,
        username: UserPreferences.myUser.username,
        fullName: UserPreferences.myUser.fullName,
        email: UserPreferences.myUser.email,
        photoUrl: UserPreferences.myUser.photoUrl,
        studentNumber: 070220762);

    // return User object
  }

  static Future<Chapter> getChapterData(int chapterId) async {
    // var response = http.get(Uri.parse("efe.com/chapter/get/1947"));

    return Chapter(
        id: chapterId,
        describtion: "<3 <3 <3",
        name: "ITU ACM",
        adminIdList: [070220762],
        activeIdList: [070220762],
        eventIdList: [21, 22, 23]);

    // return Chapter Object
  }

  static Future<List<Event>> getAllEvents() async {
    // var response = http.get(Uri.parse("efe.com/event/get/all"));
    return [
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
    ];
    // return List of event object
  }

  static Future<List<Event>> getHighlightedEvents() async {
    //var response = http.get(Uri.parse("efe.com/user/get/070220762"));
    return [
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
    ];
    // return List of event object
  }

  static Future<List<Event>> getParticipatedEvents() async {
    //var response = http.get(Uri.parse("efe.com/event/participated/070220762"));
    return [
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
      UserPreferences.demoEvent,
    ];
    // return List of event object
  }
}
