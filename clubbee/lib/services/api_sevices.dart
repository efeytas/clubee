import 'dart:convert';
import 'dart:io';
import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/models/chapter.dart';
import 'package:clubbee/models/user.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:clubbee/models/event.dart';

class ApiServices {
  static const String baseUrl =
      "http://clubeeserver.eu-central-1.elasticbeanstalk.com/api";

  static const headers = {
    "auth-key":
        "0d5d254b22d390d9e11a132d53521a229da9fa0ae9ba009a76499f57c1d64e30"
  };

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

  static getActiveChapters(String studentNumber) async {
    var response = await http.get(
        Uri.parse("$baseUrl/activechapters/$studentNumber"),
        headers: headers);
    print(response.body);
    return jsonDecode(response.body);
  }

  static Future<List<Event>> getAppliedEvents(String schoolId) async {
    var response = await http.get(Uri.parse("$baseUrl/event/applied/$schoolId"),
        headers: headers);

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

  static Future<Event> getEvent(int eventId) async {
    var response =
        await http.get(Uri.parse("$baseUrl/events/$eventId"), headers: headers);

    var rawEvent = jsonDecode(response.body)[0];
    return Event(
        id: rawEvent[0],
        name: rawEvent[1],
        description: rawEvent[2],
        dateTime: rawEvent[3],
        eventStatus: getEventStatusFromInt(rawEvent[5]),
        highlighted: rawEvent[6] == 1,
        chapterId: rawEvent[7]);
  }

  static Future<bool> joinEvent(Event event) async {
    Dio dio = Dio();

    var response = await dio.post("$baseUrl/event/join",
        data: {
          "studentnumber": currentUser!.studentNumber,
          "eventid": event.id.toString()
        },
        options: Options(headers: headers));

    if (response.statusCode == 200) {
      print("Succesfully joined event");
      return true;
    } else {
      print(response.statusCode);
      print(response.data);
      return false;
    }
  }

  static Future<List<Event>> getParticipatedEvents(
      String? studentNumber) async {
    var response = await http.get(
        Uri.parse("$baseUrl/event/participated/$studentNumber"),
        headers: headers);
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

  static Future<User> getUserData(String schoolNumber) async {
    var response = await http.get(Uri.parse("$baseUrl/profile/$schoolNumber"),
        headers: headers);
    print(schoolNumber);
    var userData = jsonDecode(response.body)[0];
    return User(
        id: userData[0],
        fullName: userData[1],
        email: userData[2],
        admin_password: userData[3] ?? "",
        studentNumber: userData[4]);
  }

  static Future<Chapter> getChapterData(int chapterId) async {
    var response = await http.get(Uri.parse("$baseUrl/chapter/$chapterId"),
        headers: headers);
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
    var response =
        await http.get(Uri.parse("$baseUrl/events/all"), headers: headers);
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
    var response = await http.get(Uri.parse("$baseUrl/events/highlighted"),
        headers: headers);
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
