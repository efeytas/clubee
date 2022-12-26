import 'package:clubbee/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import '../favorite/favorite.dart';
import '../home/home_page.dart';
import '../profile/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) => setState(() {
          _selectedIndex = index;
        }),
        barColor: Colors.amber,
        margin: EdgeInsets.all(0.0),
        domeHeight: 20,
        domeCircleColor: Colors.white,
        tabs: [
          MoltenTab(
            unselectedColor: Colors.white,
            icon: Icon(Icons.home),
            selectedColor: Colors.amber,
          ),
          MoltenTab(
            unselectedColor: Colors.white,
            icon: Icon(Icons.grade),
            selectedColor: Colors.amber,
          ),
          MoltenTab(
              unselectedColor: Colors.white,
              icon: Icon(Icons.person),
              selectedColor: Colors.amber),
        ],
      ),
    );
  }
}
