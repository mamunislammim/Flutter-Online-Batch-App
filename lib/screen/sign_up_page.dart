import 'dart:io';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/all_models.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String batchNumber = '';
  
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
        .ref("Student Image")
        .child(DateTime.now().microsecondsSinceEpoch.toString())
        .putFile(File(image!.path));
    _imageUrl = await snapshot.ref.getDownloadURL();
    EasyLoading.showSuccess("Done");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      // appBar: AppBar(
      //   backgroundColor: Colors.blueGrey.shade400,
      //   centerTitle: true,
      //   title: const Text(
      //     "Sign up",
      //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 60,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.cyanAccent.shade700,
                      radius: 55,
                      backgroundImage:
                      image != null ? FileImage(File(image!.path)) : null,
                      child: image != null
                          ? null
                          : Icon(
                        Icons.image_outlined,
                        size: 50,
                      ),
                    ),
                    Positioned(
                      right: -20,
                      bottom: -5,
                      child: InkWell(
                          onTap: () async {
                            await _imagePicker();
                          },
                          child:   Card(
                            // color: Colors.blueGrey.shade200,
                            color: Colors.transparent,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.cyanAccent.shade400,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.grey.shade50,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    // labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.grey.shade50,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              child: TextField(
                controller: _instituteController,
                decoration: InputDecoration(
                  //  labelText: "Enter Your Institute Name",
                    hintText: "Enter Your Institute Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.grey.shade50,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Enter Your Email Address",
                    // labelText: "Enter Your Email Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.grey.shade50,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    hintText: "Enter Your Contact Number",
                    // labelText: "Enter Your Contact Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15,
                      child: Checkbox(
                          value: batchNumber == '1',
                          onChanged: (value){
                            setState(() {
                              batchNumber = '1';
                            });
                          }
                      ),
                    ),
                    const Text("First Batch"),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Checkbox(
                          value: batchNumber == '2',
                          onChanged: (value){
                            setState(() {
                              batchNumber = '2';
                            });
                          }
                      ),
                    ),
                    const Text("Second Batch"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              color: Colors.cyanAccent.shade700,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              child: GestureDetector(
                onTap: () async {
                  if (_nameController.text.isNotEmpty &&
                      _instituteController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      image != null && batchNumber != '') {
                    bool result =
                    await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      await setImages();
                      var dateT = DateTime.now().minute.toString() + DateTime.now().second.toString();
                      var ran = Random().nextInt(4);
                      print("__________________ $ran");
                      var uniqueKeys =
                          "${batchNumber}_${dateT}_$ran";
                      var model = SignUpModel(
                          studentName: _nameController.text,
                          studentContact: _phoneController.text,
                          email: _emailController.text,
                          instituteName: _instituteController.text,
                          uniqueKey: uniqueKeys.toLowerCase(),
                          pictureUrl: _imageUrl, batchNo: batchNumber.toString(),
                      );

                      EasyLoading.show(status: "Updating Data");
                      await FirebaseDatabase.instance
                          .ref('Batch_$batchNumber')
                          .child("${_nameController.text}_$uniqueKeys")
                          .set(model.toJson());
                      await EasyLoading.showSuccess("Success");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    } else {
                      EasyLoading.showError(
                          "Please, Check Internet Connection");
                    }
                  } else {
                    EasyLoading.showError("Please, Fill up all Fields");
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Create an Account",
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
    );
  }
}