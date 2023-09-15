import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/screen/home_page.dart';
import 'package:our_flutter_team/screen/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/all_models.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String batchNumber = '';


  Future<bool> getData(String phn, String pass, String batch) async {
    List<SignUpModel> data = await GetAllData().getUserInfo(batchNumber);
    for(var a in data){
      var uKey = a.uniqueKey!.replaceAll('_', '');
      print("_______data______${a.studentContact}___ ${a.uniqueKey}  ${a.batchNo}");
      print("_______log______$phn $pass $batch");
      if(a.studentContact == phn && uKey == pass && a.batchNo == batch){
        print("__________________ Found  ");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("uid", a.uniqueKey.toString());
        prefs.setString("name", a.studentName.toString());
        prefs.setString("email", a.email.toString());
        prefs.setString("institute", a.instituteName.toString());
        prefs.setString("phone", a.studentContact.toString());
        prefs.setString("img", a.pictureUrl.toString());
        prefs.setString('batchNumber', a.batchNo.toString());
        prefs.setString('batchID', a.batchID.toString());
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('asset/image/login.png'),
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.1,
                  ),
                  Card(
                    color: Colors.white.withOpacity(.8),
                    child: TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter Phone Number",
                          prefixIcon: const Icon(
                            Icons.call,
                            color: Colors.grey,
                          ),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(.5)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white.withOpacity(.8),
                    child: TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: "Enter Password",
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.grey,
                          ),
                          hintStyle: const TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(.5)))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15,
                            child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.cyanAccent.shade700,
                                side: BorderSide(
                                    color: Colors.cyanAccent.shade700,
                                    width: 2),
                                value: batchNumber == '1',
                                onChanged: (value) {
                                  setState(() {
                                    batchNumber = '1';
                                  });
                                }),
                          ),
                          const Text(
                            "First Batch",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15,
                            child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.cyanAccent.shade700,
                                side: BorderSide(
                                    color: Colors.cyanAccent.shade700,
                                    width: 2),
                                value: batchNumber == '2',
                                onChanged: (value) {
                                  setState(() {
                                    batchNumber = '2';
                                  });
                                }),
                          ),
                          const Text(
                            "Second Batch",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: ()async{
                      if(_numberController.text != '' && _passController.text != '' && batchNumber != ''){
                        EasyLoading.show(status: "Loading Data");
                        bool res =  await getData(_numberController.text, _passController.text, batchNumber);
                        if(res){
                          await EasyLoading.showSuccess("Success");
                          if(mounted){
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context)=> const HomePage()),
                                    (route) => false);
                          }
                        }else{
                          await EasyLoading.showError("Wrong User");
                        }
                      }
                    },
                    child: Card(
                      color: Colors.cyanAccent.shade700,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                              (route)=> false
                          );
                        },
                        child: const Text("Create an account."),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
