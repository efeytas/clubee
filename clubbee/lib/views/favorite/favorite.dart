import 'package:clubbee/preferences.dart';
import 'package:clubbee/views/home/event_card.dart';
import 'package:flutter/material.dart';
import 'package:clubbee/demo_values.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return EventCard(
            event: UserPreferences.demoEvent,
          );
        },
      ),
    );
  }
}
