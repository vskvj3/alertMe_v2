import 'package:flutter/material.dart';
import 'package:AlertMe/pages/AlerPage.dart';
import 'package:AlertMe/widgets/HamburgerMenu.dart';
import 'package:AlertMe/pages/NearByAlerts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[AlertPage(), AlertsNear()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text(
            'AlertMe',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: const [
            HamburgerMenu(),
          ],
        ),
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Alert',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'NearBy Alerts',
            ),
          ],
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          backgroundColor: const Color.fromRGBO(170, 213, 253, 1),
          selectedItemColor: const Color.fromARGB(255, 207, 41, 0),
          selectedFontSize: 16.0,
          selectedIconTheme: const IconThemeData(size: 30.0),
        ),
      ),
    );
  }
}
