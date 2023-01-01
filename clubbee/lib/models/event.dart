enum EventStatus { active, deactive }

class Event {
  final int id;
  final String name;
  final String description;
  final String dateTime;
  final EventStatus eventStatus;
  final bool highlighted;
  final int chapterId;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      required this.dateTime,
      required this.eventStatus,
      required this.highlighted,
      required this.chapterId});
}
