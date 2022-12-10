import 'package:clubbee/models/event.dart';
import 'package:clubbee/preferences.dart';
import 'package:clubbee/utils/text_styles.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 844 * 443,
          ),
          child: Column(
            children: [
              _EventCardTitle(eventName: widget.event.name),
              _EventCardDescribtion(eventDesc: widget.event.description),
              const _EventCardButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCardButtons extends StatelessWidget {
  const _EventCardButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 375 * 157,
          height: MediaQuery.of(context).size.height / 844 * 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromRGBO(246, 185, 59, 0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.favorite),
              Text(
                "Join",
                style: TextStyle(color: Colors.black, fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCardDescribtion extends StatelessWidget {
  final String eventDesc;
  const _EventCardDescribtion({
    Key? key,
    required this.eventDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Text(
          eventDesc,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}

class _EventCardTitle extends StatelessWidget {
  final String eventName;
  const _EventCardTitle({
    Key? key,
    required this.eventName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: double.maxFinite,
                  backgroundImage:
                      NetworkImage(UserPreferences.myUser.photoUrl),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        eventName,
                        style: ClubeeStyles.eventTitle,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      print("more");
                    },
                  )),
            ],
          ),
        ));
  }
}
