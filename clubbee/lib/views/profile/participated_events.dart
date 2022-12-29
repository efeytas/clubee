import 'dart:math';

import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/models/event.dart';
import 'package:clubbee/services/api_sevices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appbar.dart';
import '../../widgets/single_event_page.dart';

class ParticipatedEventsPage extends StatefulWidget {
  const ParticipatedEventsPage({super.key});

  @override
  State<ParticipatedEventsPage> createState() => _ParticipatedEventsPageState();
}

class _ParticipatedEventsPageState extends State<ParticipatedEventsPage> {
  bool _isLoading = true;
  List<Event> participated_events = [];
  _getData() async {
    var _events =
        await ApiServices.getParticipatedEvents(currentUser?.studentNumber);
    participated_events = _events;
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
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : _buildEventsList(participated_events));
  }

  Widget _buildEventsList(List<Event> events) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var _event = events[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                title: Text(_event.name),
                subtitle: Text(_event.dateTime),
                trailing: IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    Get.to(() => SingleEventPage(eventId: _event.id));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
