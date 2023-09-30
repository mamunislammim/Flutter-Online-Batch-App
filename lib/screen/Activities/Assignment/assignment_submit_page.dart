import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:our_flutter_team/Widgets/custom_functions.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';

import '../../../models/assignment_submit_model.dart';

class AssignmentSubmitScreen extends StatefulWidget {
  const AssignmentSubmitScreen({Key? key, required this.uniqueKey}) : super(key: key);
  final String? uniqueKey;
  @override
  State<AssignmentSubmitScreen> createState() => _AssignmentSubmitScreenState();
}

class _AssignmentSubmitScreenState extends State<AssignmentSubmitScreen> {
bool _isTapped = false;

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
        .ref("Assignment_answer_Batch_$myBatch")
        .child("${myName}_${myBatchID}_${DateTime.now().microsecondsSinceEpoch.toString()}")
        .putFile(File(image!.path));
    _imageUrl = await snapshot.ref.getDownloadURL();
    EasyLoading.showSuccess("Done");
    setState(() {});
  }

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
                        )),
                  )
                      : const SizedBox()
                ],
              ),
           _isTapped ?  Card(
             margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
             color: Colors.grey,
             shape: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15),
                 borderSide: BorderSide.none),
             child: GestureDetector(
              onTap: (){},
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
           ) :  Card(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                color: Colors.blueGrey,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                child: GestureDetector(
                  onTap: () async {
                      setState(() {
                        _isTapped = true;
                      });
                      if (image != null) {
                        await setImages();
                        var model = AssignmentDataModel(
                            dateTime: "${DateTime.now()}",
                            uniqueKey: widget.uniqueKey,
                            pictureUrl: _imageUrl, name: myName, batchID: myBatchID);
                        EasyLoading.show(status: "Updating Data");
                        var d = DateTime.now()
                            .toString()
                            .replaceAll(":", "")
                            .replaceAll(" ", "_")
                            .replaceAll("-", "")
                            .replaceAll(".", "")
                            .substring(0, 15);
                         await FirebaseDatabase.instance
                            .ref('Assignment_submit_$myBatch')
                            .child(widget.uniqueKey.toString())
                            .child("${myUID}_$d")
                            .set(model.toJson());
                        await EasyLoading.showSuccess("Success");
                        setState(() {
                          _isTapped = false;
                        });
                        Navigator.pop(context);
                      }else{
                        setState(() {
                          _isTapped = false;
                        });
                        showToast("Select Image", Colors.red);
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
    );
  }
}

