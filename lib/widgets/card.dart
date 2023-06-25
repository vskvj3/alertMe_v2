import 'package:flutter/material.dart';


class FAQCard extends StatelessWidget {
  final String question;
  final String answer;

  FAQCard({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(question),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
