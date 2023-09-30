import 'package:flutter/material.dart';
import 'package:our_flutter_team/Widgets/custom_functions.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/models/class_link_models.dart';
import 'package:our_flutter_team/screen/Activities/Class_Links/create_class_link_page.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Common Files/app_colors.dart';

class ClassLinkPage extends StatefulWidget {
  const ClassLinkPage({super.key});

  @override
  State<ClassLinkPage> createState() => _ClassLinkPageState();
}

class _ClassLinkPageState extends State<ClassLinkPage> {
  String classLink = "";
  String classStartTime = '0000-00-00 00:00:00';
  String classEndTime = '';
  bool isActiveClass = false;
  bool isUpComingClass = false;
  bool isTimeUp = false;

  setClassDetails(String start, String end, String link) {
    classStartTime = "SS";
    classEndTime = "MM";
    classLink = "AA";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.shade700,
        title: const Text("Class Link"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isTimeUp
                  ? Card(
                      color: cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, $myName",
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Class is over. \nPlease wait until the next class time.\nThanks",
                              style: const TextStyle(
                                  color: Colors.black87,
                                  // fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    )
                  : Card(
                      color: cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, $myName",
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Class Link : ",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            SelectableText(
                              classLink.toString(),
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Class Date :   ${classStartTime.substring(0, 11)} ",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                            Text(
                              "Class Time :   ${classStartTime.substring(11, 16)} ",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: GetAllData().getClassLink(myBatch),
                builder: (BuildContext context, snapshot) {
                  DateTime nowDT = DateTime.now();
                  if (snapshot.hasData) {
                    List<ClassLinkModels> data = snapshot.data!.toList();
                    List<ClassLinkModels> result = [];
                    for (var i in data) {
                      var startDate = DateTime.tryParse(i.startTime.toString());
                      var endDate = DateTime.tryParse(i.endTime.toString());
                      isActiveClass =
                          nowDT.isAfter(startDate!) && nowDT.isBefore(endDate!);
                      isTimeUp = nowDT.isAfter(endDate!);
                      print(
                          "________ time up : $isTimeUp isActive : $isActiveClass st : $startDate  en : $endDate");
                      if (isActiveClass) {
                        result.add(ClassLinkModels(
                            url: i.url,
                            startTime: i.startTime,
                            endTime: i.endTime));
                        break;
                      } else if (isTimeUp) {
                        result.add(ClassLinkModels(
                            url: "Link Not Found",
                            startTime: "0000:00:00  00:00:00",
                            endTime: "0000:00:00  00:00:00"));
                      } else {
                        result.add(ClassLinkModels(
                            url: i.url,
                            startTime: i.startTime,
                            endTime: i.endTime));
                      }
                    }
                    return isActiveClass
                        ? InkWell(
                            onTap: () {
                             setState(() {
                               classLink = result[0].url.toString();
                               classStartTime = result[0].startTime.toString();
                               classEndTime = result[0].endTime.toString();
                             });
                              print("____ $classLink");
                              openUrl(classLink);
                              classLink = result[0].url.toString();
                              classStartTime = result[0].startTime.toString();
                              classEndTime = result[0].endTime.toString();
                            },
                            child:   Card(
                              color: buttonColor,
                              child: const SizedBox(
                                height: 60,
                                width: 200,
                                child: Center(
                                  child: Text(
                                    "Join Class",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                classLink = result[0].url.toString();
                                classStartTime = result[0].startTime.toString();
                                classEndTime = result[0].endTime.toString();
                              });
                              showToast(
                                  "It's not class time yet.!\nPlease Wait",
                                  buttonColor);
                            },
                            child:   Card(
                              color: buttonColor.withOpacity(.2),
                              child: SizedBox(
                                height: 60,
                                width: 200,
                                child: Center(
                                  child: Text(
                                    "Join Class",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something wrong"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: myPhn == "01761810531"
          ? FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateClassLinkPage()));
              },
              child: const Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
            )
          : const SizedBox(),
    );
  }

  // Future openUrl(String url) async {
  //   try {
  //     if (await launchUrl(Uri.parse(url),
  //         mode: LaunchMode.externalApplication)) {
  //       debugPrint("______ 1 Url : $url");
  //       showToast("Success", Colors.green);
  //     } else if (await launchUrl(Uri.parse("https://$url"),
  //         mode: LaunchMode.externalApplication)) {
  //       debugPrint("______ 2 Url : $url");
  //       showToast("Success", Colors.green);
  //     } else {
  //       debugPrint("______ 3 Url : $url");
  //       showToast("Could not launch", Colors.red);
  //     }
  //   } catch (e) {
  //     debugPrint("______ 4 Url : $url  $e");
  //     showToast("Could not launch", Colors.red);
  //   }
  // }
}
