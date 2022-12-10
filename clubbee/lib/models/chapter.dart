class Chapter {
  final int id;
  final String describtion;
  final String name;
  final List<int> adminIdList;
  final List<int> activeIdList;
  final List<int> eventIdList;

  Chapter(this.id, this.describtion, this.name, this.adminIdList,
      this.activeIdList, this.eventIdList);
}
