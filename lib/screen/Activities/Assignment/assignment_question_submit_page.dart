import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import '../../../Widgets/custom_functions.dart';
import '../../../models/assignment_question_submit_model.dart';

class AssignmentQuestionSubmitScreen extends StatefulWidget {
  const AssignmentQuestionSubmitScreen({Key? key, this.uniqueKey})
      : super(key: key);
  final String? uniqueKey;
  @override
  State<AssignmentQuestionSubmitScreen> createState() =>
      _AssignmentQuestionSubmitScreenState();
}

class _AssignmentQuestionSubmitScreenState
    extends State<AssignmentQuestionSubmitScreen> {
  final TextEditingController _textControllers = TextEditingController();
  final TextEditingController _marksControllers = TextEditingController();

  XFile? image;
  Future<void> _imagePicker() async {
    ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  String? _imageUrl;
  Future<void> setImages() async {
    EasyLoading.show(status: "Uploading Image");
    var snapshot = await FirebaseStorage.instance
        .ref("Assignment_Question_Batch_$myBatch")
        .child("${myName}_${myBatchID}_${DateTime.now().toString()}")
        .putFile(File(image!.path));
    _imageUrl = await snapshot.ref.getDownloadURL();
    EasyLoading.showSuccess("Done");
    setState(() {});
  }

  String startDateTime = 'Select Start Date Time';
  String endDateTime = 'Select End Date Time';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text("Upload Your Design"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Card(
                      color: Colors.blueGrey.shade300,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: size.height * .4,
                        width: size.width * .8,
                        decoration: BoxDecoration(
                            image: image != null
                                ? DecorationImage(
                                    image: FileImage(File(image!.path)),
                                    fit: BoxFit.cover)
                                : null),
                        child: image != null
                            ? null
                            : GestureDetector(
                                onTap: () async {
                                  await _imagePicker();
                                },
                                child: const Icon(
                                  Icons.image_outlined,
                                  size: 180,
                                  color: Colors.blueGrey,
                                ),
                              ),
                      ),
                    ),
                    image != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                image = null;
                              });
                            },
                            child: Card(
                              color: Colors.blueGrey.shade50,
                              child: const Icon(
                                Icons.close,
                                size: 40,
                                color: Colors.blueGrey,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
                Card(
                  color: Colors.grey.shade50,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  child: TextField(
                    controller: _textControllers,
                    decoration: InputDecoration(
                        hintText: "Enter Your Question Here",
                        // labelText: "Enter Your Email Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
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
                SizedBox(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _marksControllers,
                    decoration: InputDecoration(
                        hintText: "Assignment Marks",
                        // labelText: "Enter Your Email Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  color: Colors.blueGrey,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  child: GestureDetector(
                    onTap: () async {
                      if (image != null) {
                        await setImages();
                        var d = DateTime.now()
                            .toString()
                            .replaceAll(":", "")
                            .replaceAll(" ", "_")
                            .replaceAll("-", "")
                            .replaceAll(".", "")
                            .substring(0, 15);
                        var model = AssignmentQsnSubmitModel(
                            dateTime: d,
                            uniqueKey: widget.uniqueKey,
                            pictureUrl: _imageUrl,
                            text: _textControllers.text,
                            startDT: startDateTime,
                            endDT: endDateTime,
                            marks: _marksControllers.text);
                        EasyLoading.show(status: "Updating Data");
                        await FirebaseDatabase.instance
                            .ref('Assignment_Question_Batch_$myBatch')
                            .child(d)
                            .set(model.toJson());
                        await EasyLoading.showSuccess("Success");
                        Navigator.pop(context);
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Upload Image",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
