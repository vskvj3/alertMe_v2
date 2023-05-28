import 'package:alert_me/pages/about_page.dart';
import 'package:alert_me/pages/faq_page.dart';
import 'package:alert_me/pages/emergency_contacts_page.dart';
import 'package:alert_me/pages/settings_page.dart';
import 'package:alert_me/pages/emergency_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      constraints: const BoxConstraints(
        minWidth: 250,
      ),
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
              builder: (context) => const SettingsPage(),
            ),
          );
          debugPrint('Settings Page');
        } else if (choice == 'Emergency Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmergencyProfilePage(),
            ),
          );
          debugPrint('Emergency Profile Page');
        } else if (choice == 'Emergency Contacts') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmergencyContactsPage(),
            ),
          );
          debugPrint('Emergency Contacts Page');
        } else if (choice == 'FAQ') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FAQPage(),
            ),
          );
          debugPrint('FAQ Page');
        } else if (choice == 'About') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutPage(),
            ),
          );
          debugPrint('About Page');
        } else if (choice == 'Quit') {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          debugPrint('Quit');
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'Settings',
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Emergency Profile',
            child: Text(
              'Emergency Profile',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Emergency Contacts',
            child: Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'FAQ',
            child: Text(
              'FAQ',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'About',
            child: Text(
              'About',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'Quit',
            child: Text(
              'Quit',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ];
      },
    );
  }
}
