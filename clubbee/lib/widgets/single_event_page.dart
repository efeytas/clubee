import 'package:clubbee/views/home/event_card.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../services/api_sevices.dart';
import 'appbar.dart';

class SingleEventPage extends StatefulWidget {
  final int eventId;
  const SingleEventPage({super.key, required this.eventId});

  @override
  State<SingleEventPage> createState() => _SingleEventPageState();
}

class _SingleEventPageState extends State<SingleEventPage> {
  bool _isLoading = true;
  Event? event;
  _getData() async {
    event = await ApiServices.getEvent(widget.eventId);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : EventCard(
              event: event!,
              isJoined: true,
              isAlreadyJoined: true,
            ),
    );
  }
}
