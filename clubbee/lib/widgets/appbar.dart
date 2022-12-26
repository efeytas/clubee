import 'package:flutter/material.dart';

class AppBarScreen extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarScreen({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ClubBee'),
      centerTitle: true,
      backgroundColor: Colors.amber,
      shadowColor: Colors.amber,
      toolbarHeight: 100,
    );
  }
}
