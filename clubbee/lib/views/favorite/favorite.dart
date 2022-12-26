import 'package:clubbee/views/home/event_card.dart';
import 'package:flutter/material.dart';

import '../../global_parameters.dart';
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
    var events = await ApiServices.getAllEvents();
    await Future.delayed(const Duration(milliseconds: 500));
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
                return EventCard(
                  event: higlightedEvents[index],
                );
              },
            ),
    );
  }
}
