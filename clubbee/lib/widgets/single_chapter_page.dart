import 'package:clubbee/models/chapter.dart';
import 'package:clubbee/views/home/event_card.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../services/api_sevices.dart';
import 'appbar.dart';

class SingleChapterPage extends StatefulWidget {
  final int chapterId;
  const SingleChapterPage({super.key, required this.chapterId});

  @override
  State<SingleChapterPage> createState() => _SingleChapterPageState();
}

class _SingleChapterPageState extends State<SingleChapterPage> {
  bool _isLoading = true;
  late Event event;
  Chapter? chapter;
  _getData() async {
    chapter = await ApiServices.getChapterData(widget.chapterId);
    event = Event(
        id: 0,
        name: chapter!.name,
        description: chapter!.describtion,
        dateTime: "dateTime",
        eventStatus: EventStatus.active,
        highlighted: false,
        chapterId: chapter!.id);
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
        body: Center(
          child: (_isLoading)
              ? const CircularProgressIndicator.adaptive()
              : EventCard(
                  isAlreadyJoined: true,
                  event: event,
                  isJoined: true,
                ),
        ));
  }
}
