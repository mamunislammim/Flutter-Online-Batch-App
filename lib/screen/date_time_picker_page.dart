// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//       });
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay pickedTime = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//
//     if (pickedTime != null && pickedTime != selectedTime) {
//       setState(() {
//         selectedTime = pickedTime;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//     String formattedTime = selectedTime.format(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Date and Time Picker Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextButton(
//             onPressed: () {
//       DatePicker.showDatePicker(context,
//       showTitleActions: true,
//       minTime: DateTime(2019, 3, 5),
//       maxTime: DateTime(2022, 1, 1), onChanged: (date) {
//       }, onConfirm: (date) {
//       print('Confirmed $date');
//       }, currentTime: DateTime.now(), locale: LocaleType.it);
//       },
//           child: Text(
//             'Show Datetime picker (italian)',
//             style: TextStyle(color: Colors.blue),
//           ));
//
//
//
//       Text(
//               'Selected Date: $formattedDate',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Selected Time: $formattedTime',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text('Select Date'),
//             ),
//             ElevatedButton(
//               onPressed: () => _selectTime(context),
//               child: Text('Select Time'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }