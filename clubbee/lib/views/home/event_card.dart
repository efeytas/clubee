import 'package:clubbee/global_parameters.dart';
import 'package:clubbee/models/event.dart';
import 'package:clubbee/services/api_sevices.dart';
import 'package:clubbee/utils/text_styles.dart';
import 'package:clubbee/widgets/single_chapter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final bool isAlreadyJoined;
  bool? isJoined;
  EventCard(
      {super.key,
      required this.event,
      this.isJoined,
      required this.isAlreadyJoined});

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
              _EventCardTitle(
                eventName: widget.event.name,
                chapterPhoto: null,
                chapterID: widget.event.chapterId,
              ),
              _EventCardDescribtion(eventDesc: widget.event.description),
              if (widget.isJoined != true)
                _EventCardButtons(
                  eventDate: widget.event.dateTime,
                  event: widget.event,
                  isAlreadyJoined: widget.isAlreadyJoined,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCardButtons extends StatefulWidget {
  final Event event;
  final String eventDate;
  bool isAlreadyJoined;

  _EventCardButtons({
    Key? key,
    required this.eventDate,
    required this.event,
    required this.isAlreadyJoined,
  }) : super(key: key);

  @override
  State<_EventCardButtons> createState() => _EventCardButtonsState();
}

class _EventCardButtonsState extends State<_EventCardButtons> {
  bool isLoadingJoin = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Event Date: ${widget.eventDate}"),
          ),
          GestureDetector(
            onTap: () async {
              if (widget.isAlreadyJoined == false) {
                setState(() {
                  isLoadingJoin = true;
                });
                bool isSuccess = await ApiServices.joinEvent(widget.event);
                if (isSuccess) {
                  setState(() {
                    appliedEvents.add(widget.event);
                    widget.isAlreadyJoined = true;
                    isLoadingJoin = false;
                  });
                } else {
                  setState(() {
                    isLoadingJoin = false;
                  });
                }
              }
            },
            child: Center(
              child: (isLoadingJoin)
                  ? const CircularProgressIndicator.adaptive()
                  : Container(
                      width: MediaQuery.of(context).size.width / 375 * 157,
                      height: MediaQuery.of(context).size.height / 844 * 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromRGBO(246, 185, 59, 0.2),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!widget.isAlreadyJoined)
                            SvgPicture.asset(
                              "assets/join_emoji.svg",
                              height:
                                  MediaQuery.of(context).size.height / 844 * 30,
                            ),
                          Text(
                            (widget.isAlreadyJoined) ? "Applied" : "Join",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ],
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
  final String? chapterPhoto;
  final int chapterID;
  const _EventCardTitle(
      {Key? key,
      required this.eventName,
      required this.chapterPhoto,
      required this.chapterID})
      : super(key: key);

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
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => SingleChapterPage(chapterId: chapterID));
                  },
                  child: SizedBox(
                    width: double.maxFinite,
                    child: _buildChapterImage(chapterID),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventName,
                        style: ClubeeStyles.eventTitle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _buildChapterImage(chapterID) {
    switch (chapterID) {
      case 1:
        return Image.asset("assets/chapters/ituacm-blue.png");
      case 2:
        return Image.asset("assets/chapters/dsc.png");
      case 3:
        return Image.network(
            "https://instagram.fesb7-1.fna.fbcdn.net/v/t51.2885-19/245835174_432440038453479_7891076317472632982_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fesb7-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=1JiQbHV_Q9kAX8b8fSC&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfB7iCLuPaT0ZWmKY-IdOod1dyMS9BRVGrK6L4MauSay6w&oe=63B1F084&_nc_sid=8fd12b");
      case 4:
        return Image.asset("assets/chapters/emk.jpeg");
      default:
        {
          return null;
        }
    }
  }
}
