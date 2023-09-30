import 'package:flutter/material.dart';
import 'package:our_flutter_team/Common%20Files/app_colors.dart';
import 'package:our_flutter_team/Widgets/custom_drawer.dart';
import 'package:our_flutter_team/Widgets/custom_functions.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/screen/Activities/Class_Links/class_link_page.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import 'package:our_flutter_team/screen/students_activity_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Activities/Assignment/assignment_list_page.dart';
import 'Activities/Notice/notice_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  Future checkLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myUID = prefs.getString("uid") ?? '';
      myName = prefs.getString("name") ?? '';
      myEmail = prefs.getString("email") ?? '';
      myInstitute = prefs.getString("institute") ?? '';
      myProfile = prefs.getString("img") ?? '';
      myBatch = prefs.getString("batchNumber") ?? '';
      myPhn = prefs.getString("phone") ?? '';
      myBatchID = prefs.getString('batchID') ?? '';
      myPassword = prefs.getString('pass') ?? '';
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      showToast("Double tap to exit this app", Colors.red);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return onWillPop();
      },
      child: Scaffold(
        endDrawer:
            CustomDrawer(name: myName, phn: myPhn, img: myProfile, email: myEmail),
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text("Flutter Team"),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFe6ffff), Color(0xFF008ae6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentsActivityScreen(
                            uid: myUID,
                            email: myEmail,
                            institute: myInstitute,
                            name: myName,
                            img: myProfile,
                            phn: myPhn,
                            batch: myBatch,
                            batchID: myBatchID,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Image.asset('asset/image/student.png')),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myName.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Text(
                                    "Flutter Developer",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '  Batch: 1 ',
                        style: TextStyle(
                            color: Color(0xff006666),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Code: 20230502',
                        style: TextStyle(
                            color: Color(0xff006666),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 130,
                    child: FutureBuilder(
                        future: GetAllData().getUserInfo('1'),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StudentsActivityScreen(
                                            uid: snapshot.data![index].uniqueID
                                                .toString(),
                                            email: snapshot.data![index].email
                                                .toString(),
                                            institute: snapshot
                                                .data![index].instituteName
                                                .toString(),
                                            name: snapshot
                                                .data![index].studentName
                                                .toString(),
                                            img: snapshot
                                                .data![index].pictureUrl
                                                .toString(),
                                            phn: snapshot
                                                .data![index].studentContact
                                                .toString(),
                                            batch: snapshot.data![index].batchNo
                                                .toString(),
                                            batchID: snapshot
                                                .data![index].batchID
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 125,
                                      width: 125,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 12,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'asset/image/student.png',
                                              height: 70,
                                              width: 100,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.data![index].studentName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF008ae6)),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '  Batch:2 ',
                        style: TextStyle(
                            color: Color(0xff006666),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Code: 20230825',
                        style: TextStyle(
                            color: Color(0xff006666),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 130,
                    child: FutureBuilder(
                        future: GetAllData().getUserInfo('2'),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StudentsActivityScreen(
                                            uid: snapshot.data![index].uniqueID
                                                .toString(),
                                            email: snapshot.data![index].email
                                                .toString(),
                                            institute: snapshot
                                                .data![index].instituteName
                                                .toString(),
                                            name: snapshot
                                                .data![index].studentName
                                                .toString(),
                                            img: snapshot
                                                .data![index].pictureUrl
                                                .toString(),
                                            phn: snapshot
                                                .data![index].studentContact
                                                .toString(),
                                            batch: snapshot.data![index].batchNo
                                                .toString(),
                                            batchID: snapshot
                                                .data![index].batchID
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 125,
                                      width: 125,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 12,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'asset/image/student.png',
                                              height: 70,
                                              width: 100,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.data![index].studentName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF008ae6)),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.cyanAccent.withOpacity(.6),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Our Activities",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (myBatch == "1") {
                            openUrl(
                                'https://youtube.com/playlist?list=PLvWxHe0OLZ4zWXslPzzx-jCNz0P_YjFrT&si=iPDSyBwJtgxw6SfS');
                          } else {
                            openUrl(
                                'https://youtube.com/playlist?list=PLvWxHe0OLZ4zFHWeRzWI5mqLAn2Rn5MN1&si=Me0047qPdFQshYi5');
                          }
                        },
                        child: Card(
                          color: cardColor,
                          child: SizedBox(
                            height: 60,
                            width: size.width / 2 - 20,
                            child: const Center(
                                child: Text(
                              "Class Videos",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AssignmentListPage(),
                            ),
                          );
                        },
                        child: Card(
                          color: cardColor,
                          child: SizedBox(
                            height: 60,
                            width: size.width / 2 - 20,
                            child: const Center(
                              child: Text(
                                "Assignment",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ClassLinkPage()));
                        },
                        child: Card(
                          color: cardColor,
                          child: SizedBox(
                            height: 60,
                            width: size.width / 2 - 20,
                            child: const Center(
                                child: Text(
                              "Class Link",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // showToast("Working on it", Colors.green);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NoticePage()));
                        },
                        child: Card(
                          color: cardColor,
                          child: SizedBox(
                            height: 60,
                            width: size.width / 2 - 20,
                            child: const Center(
                                child: Text(
                              "Notice",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showToast("Working on it", Colors.green);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                        },
                        child: Card(
                          color: cardColor,
                          child: SizedBox(
                            height: 60,
                            width: size.width / 2 - 20,
                            child: const Center(
                              child: Text(
                                "Communication",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          showToast("Working on it", Colors.green);
                          await GetAllData().assignmentQuestionData();
                        },
                        child: Card(
                          color: cardColor,
                          child: SizedBox(
                            height: 60,
                            width: size.width / 2 - 20,
                            child: const Center(
                              child: Text(
                                "Results",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
