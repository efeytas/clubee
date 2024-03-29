import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/models/event.dart';
import 'package:clubbee/services/api_sevices.dart';
import 'package:clubbee/views/home/event_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isLoading = true;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    var events = await ApiServices.getAllEvents();
    setState(() {
      mainStreamEvents = events;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_isLoading)
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : ListView.builder(
              itemCount: mainStreamEvents.length,
              itemBuilder: (BuildContext context, int index) {
                return (mainStreamEvents[index].eventStatus ==
                        EventStatus.active)
                    ? EventCard(
                        event: mainStreamEvents[index],
                        isAlreadyJoined:
                            checkForAlreadyJoined(mainStreamEvents[index]),
                      )
                    : Container();
              },
            ),
    );
  }

  bool checkForAlreadyJoined(Event event) {
    for (var appliedEvent in appliedEvents) {
      if (event.id == appliedEvent.id) {
        return true;
      }
    }

    return false;
  }
}
