
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String toast, Color color){
  Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

Future<DateTime> selectDateTime(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    // Show time picker
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      selectedDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      print("_________${selectedDate}  ${selectedDate.runtimeType}");
      // print("___PickDate : $pickedDate  __ Pick Time : $pickedTime  ${selectedDate}");
      // var nowDT = DateTime.now();
      // print("______Now Time : $nowDT");
      // print("________     ${nowDT.isAfter(selectedDate)}   _____________ ");
    }
  }
  return selectedDate;
}