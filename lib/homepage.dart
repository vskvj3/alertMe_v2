import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:alert_me/pages/alert_page.dart';
import 'package:alert_me/widgets/hamburger_menu.dart';
import 'package:alert_me/pages/nearby_alerts.dart';
import 'package:geolocator/geolocator.dart';

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

  init() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Location is Disabled"),
              content:
                  const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    const AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  static const List<Widget> _pages = <Widget>[AlertPage(), AlertsNear()];

  @override
  Widget build(BuildContext context) {
    // LocationModule().grandPermission();
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
