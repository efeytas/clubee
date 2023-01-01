import 'package:clubbee/views/home/event_card.dart';
import 'package:flutter/material.dart';

import '../../global_parameters.dart';
import '../../models/event.dart';
import '../../services/api_sevices.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  bool _isLoading = true;
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    var events = await ApiServices.getHighlightedEvents();
    setState(() {
      higlightedEvents = events;
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
              itemCount: higlightedEvents.length,
              itemBuilder: (BuildContext context, int index) {
                return (higlightedEvents[index].eventStatus ==
                        EventStatus.active)
                    ? EventCard(
                        event: higlightedEvents[index],
                        isAlreadyJoined:
                            checkForAlreadyJoined(higlightedEvents[index]),
                      )
                    : Container();
              },
            ),
    );
  }

  bool checkForAlreadyJoined(Event event) {
    for (var mainEvent in higlightedEvents) {
      for (var appliedEvent in appliedEvents) {
        if (mainEvent.id == appliedEvent.id) {
          return true;
        }
      }
    }
    return false;
  }
}
