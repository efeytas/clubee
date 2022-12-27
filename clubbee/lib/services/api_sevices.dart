import 'dart:convert';
import 'dart:io';
import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/models/chapter.dart';
import 'package:clubbee/models/user.dart';
import 'package:http/http.dart' as http;

import 'package:clubbee/models/event.dart';

class ApiServices {
  static const String baseUrl = "http://35.159.37.120/api/";

  static getEventStatusFromInt(int i) {
    switch (i) {
      case 1:
        return EventStatus.active;
      case 2:
        return EventStatus.deactive;
      default:
        {
          return EventStatus.deactive;
        }
    }
  }

  static uploadPhotoAsBytes(File photo) {}

  static Future<bool> joinEvent(Event event) async {
    var response = await http
        .post(Uri.parse("$baseUrl/event/join"), body: {"eventID": 1232});
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  static Future<User> getUserData(String schoolNumber) async {
    var response = await http.get(Uri.parse("$baseUrl/profile/$schoolNumber"));
    var userData = jsonDecode(response.body)[0];
    return User(
        id: userData[0],
        password: userData[3],
        fullName: userData[1],
        email: userData[2],
        photoUrl: userData[4] ?? "",
        studentNumber: userData[5]);
  }

  static Future<Chapter> getChapterData(int chapterId) async {
    var response = await http.get(Uri.parse("$baseUrl/chapter/$chapterId"));
    var chapterData = jsonDecode(response.body)[0];
    return Chapter(
        id: chapterData[0],
        describtion: chapterData[1],
        name: chapterData[2],
        status: chapterData[3] == 1,
        adminId: chapterData[4]);

    // return Chapter Object
  }

  static Future<List<Event>> getAllEvents() async {
    var response = await http.get(Uri.parse("$baseUrl/events/all"));
    var rawEvents = jsonDecode(response.body);
    List<Event> events = [];
    for (var rawEvent in rawEvents) {
      events.add(Event(
          id: rawEvent[0],
          name: rawEvent[1],
          description: rawEvent[2],
          dateTime: rawEvent[3],
          eventStatus: getEventStatusFromInt(rawEvent[5]),
          highlighted: rawEvent[6] == 1,
          chapterId: rawEvent[7]));
    }

    return events;
  }

  static Future<List<Event>> getHighlightedEvents() async {
    var response = await http.get(Uri.parse("$baseUrl/events/highlighted"));
    var rawEvents = jsonDecode(response.body);
    List<Event> events = [];
    for (var rawEvent in rawEvents) {
      events.add(Event(
          id: rawEvent[0],
          name: rawEvent[1],
          description: rawEvent[2],
          dateTime: rawEvent[3],
          eventStatus: getEventStatusFromInt(rawEvent[5]),
          highlighted: rawEvent[6] == 1,
          chapterId: rawEvent[7]));
    }

    return events;
  }

  static Future<List<Event>> getParticipatedEvents() async {
    var response = await http
        .get(Uri.parse("$baseUrl/event/participated/${currentUser?.id ?? 0}"));
    var rawEvents = jsonDecode(response.body);
    List<Event> events = [];
    for (var rawEvent in rawEvents) {
      events.add(Event(
          id: rawEvent[0],
          name: rawEvent[1],
          description: rawEvent[2],
          dateTime: rawEvent[3],
          eventStatus: getEventStatusFromInt(rawEvent[5]),
          highlighted: rawEvent[6] == 1,
          chapterId: rawEvent[7]));
    }

    return events;
  }
}
