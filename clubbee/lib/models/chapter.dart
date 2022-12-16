class Chapter {
  final int id;
  final String describtion;
  final String name;
  final List<int> adminIdList;
  final List<int> activeIdList;
  final List<int> eventIdList;

  Chapter(
      {required this.id,
      required this.describtion,
      required this.name,
      required this.adminIdList,
      required this.activeIdList,
      required this.eventIdList});
}
