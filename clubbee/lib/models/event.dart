enum EventStatus { active, deactive }

class Event {
  final int id;
  final String name;
  final String description;
  final DateTime dateTime;
  final EventStatus eventStatus;
  final bool highlighted;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      required this.dateTime,
      required this.eventStatus,
      required this.highlighted});
}
