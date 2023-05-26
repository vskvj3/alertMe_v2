import 'package:AlertMe/pages/AboutPage.dart';
import 'package:AlertMe/pages/FAQpage.dart';
import 'package:AlertMe/pages/EmergencyContactsPage.dart';
import 'package:AlertMe/pages/SettingsPage.dart';
import 'package:AlertMe/pages/EmergencyProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      color: const Color.fromRGBO(170, 213, 253, 1),
      onSelected: (String choice) {
        // Handle menu item selection

        if (choice == 'Settings') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(),
            ),
          );
          print('Settings Page');
        } else if (choice == 'Emergency Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmergencyProfilePage(),
            ),
          );
          print('Emergency Profile Page');
        } else if (choice == 'Emergency Contacts') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmergencyContactsPage(),
            ),
          );
          print('Emergency Contacts Page');
        } else if (choice == 'FAQ') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FAQPage(),
            ),
          );
          print('FAQ Page');
        } else if (choice == 'About') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutPage(),
            ),
          );
          print('About Page');
        } else if (choice == 'Quit') {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          print('Quit');
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'Settings',
            child: Text('Settings'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Emergency Profile',
            child: Text('Emergency Profile'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Emergency Contacts',
            child: Text('Emergency Contacts'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'FAQ',
            child: Text('FAQ'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'About',
            child: Text('About'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Quit',
            child: Text('Quit'),
          ),
        ];
      },
    );
  }
}
