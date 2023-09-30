import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:our_flutter_team/Common%20Files/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
       }
  }
  return selectedDate;
}


Future openUrl(String url) async {
  if(url.contains("https://")){
    debugPrint("_______________ Okay");
  }else{
    debugPrint("_______________No");
    url = "https://$url";
  }
  try {
    if (await launchUrl(Uri.parse(url),
        mode: LaunchMode.platformDefault)) {
      showToast("Success", buttonColor);
    } else {
      debugPrint('#1: Could not launch $url');
      showToast("Could not launch.!", Colors.red);
    }
  } catch (e) {
    debugPrint('#2: Could not launch $url');
    debugPrint('___________ $e');
    showToast("Error..", Colors.red);
  }
}
