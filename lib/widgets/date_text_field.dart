// import 'package:flutter/material.dart';
// import 'package:date_field/date_field.dart';

// class DateTextField extends StatelessWidget {
//   final TextEditingController _dateController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: DateTimeField(
//           label: 'Date',
//           selectedDate: DateTime.now(),
//           controller: _dateController,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//           onDateSelected: (DateTime value) {
//             _dateController.text = value.toString().split(' ')[0];
//           },
//         ),
//       ),
//     );
//   }
// }