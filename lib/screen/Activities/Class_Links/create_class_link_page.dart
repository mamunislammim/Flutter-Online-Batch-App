import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';

import '../../../Common Files/app_colors.dart';
import '../../../Widgets/custom_functions.dart';
import '../../../models/class_link_models.dart';

class CreateClassLinkPage extends StatefulWidget {
  const CreateClassLinkPage({super.key});

  @override
  State<CreateClassLinkPage> createState() => _CreateClassLinkPageState();
}

class _CreateClassLinkPageState extends State<CreateClassLinkPage> {
  final TextEditingController _linkController = TextEditingController();
  String startDateTime = 'Select Start Date Time';
  String endDateTime = 'Select End Date Time';
  String batchNumber = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              color: const Color(0xffffd0a1),
              child: Column(
                children: [
                  Card(
                    color: Colors.grey.shade50,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      controller: _linkController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: "Enter Your Link here",
                          // labelText: "Enter Your Email Address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                var a = await selectDateTime(context);
                                setState(() {
                                  startDateTime = a.toString();
                                });
                              },
                              icon: const Icon(Icons.date_range)),
                          Text(startDateTime)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                var a = await selectDateTime(context);
                                setState(() {
                                  endDateTime = a.toString();
                                });
                              },
                              icon: const Icon(Icons.date_range)),
                          Text(endDateTime)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.blueGrey,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    child: GestureDetector(
                      onTap: () async {
                        EasyLoading.showToast("Creating Class");
                        var model = ClassLinkModels(
                            url: _linkController.text,
                            startTime: startDateTime,
                            endTime: endDateTime);
                        await FirebaseDatabase.instance
                            .ref("Class_Link_Batch_$myBatch").child("link")
                            .set(model.toJson());
                        Navigator.pop(context);
                        EasyLoading.showSuccess("Done");
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Class Link",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  openUrl('https://meet.google.com/');
                },
                child: const Text("Create Link")),
          ],
        ),
      ),
    );
  }
}
