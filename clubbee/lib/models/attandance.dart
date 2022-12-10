enum AttandanceStatus { yes, no }

class Attandance {
  final int id;
  final int eventId;
  final int userId;
  final AttandanceStatus attandanceStatus;

  Attandance(this.id, this.eventId, this.userId, this.attandanceStatus);
}
