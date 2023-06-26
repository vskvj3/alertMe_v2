import 'package:flutter/material.dart';
import 'package:alert_me/widgets/card.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> faqItems = [
  {
    'question': 'How does the app work?',
    'answer': 'When a user presses the panic button, the app sends out an alert to other app users and a SMS message to the emergency contacts along with the location. This allows those users to quickly respond and provide assistance',
  },
  {
    'question': 'Is the app free to use?',
    'answer': 'Yes, the app is completely free to download and use.',
  },
  {
    'question':'What is permanent notification?',
    'answer':'If you enable the permanent notification in settings, you will get a permanent notification bar on the lockscreen which can be used to access the app easily.'
  },
  {
    'question': 'Can I customize my emergency contact list?',
    'answer': ' Yes, you can edit your emergency contact list in the app. You can add anyone in your emergency contacts and also remove or update existing contacts as needed.',
  },
  {
    'question': ' Can I choose who receives the alert notifications?',
    'answer': 'Yes, the app allows you to customize the alert notifications. In the settings page, you can choose to send alert notifications to your emergency contacts, nearby app users.',
  },
  {
    'question': ' Is it possible to cancel or take back an accidental panic alert?',
    'answer': 'Yes, the app provides an option to cancel or take back a panic alert if it was pressed accidentally. When you presses the alert button, there arises a timer of 5 seconds and an option to cancel. If your are not able to cancel at that time, there will be an another aption to abort the alert in home page. This can help avoid unnecessary notifications and alerts.',
  },
  {
    'question': 'Will pressing the alert button share my location?',
    'answer': 'Yes, when you press the alert utton, app send the alert and SMS along with the location at which you send the alert.',
  },

];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(170, 219, 253, 1),
          title: const Text('FAQ',
            style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold)
          ),
        ),
        body: ListView.builder(
          itemCount: faqItems.length,
          itemBuilder: (context, index) {
          return FAQCard(
            question: faqItems[index]['question']!,
            answer: faqItems[index]['answer']!,
        );
  },
)
,
      )
    );
  }
}
