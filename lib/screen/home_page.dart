import 'package:flutter/material.dart';
import 'package:our_flutter_team/Common%20Files/app_colors.dart';
import 'package:our_flutter_team/Widgets/custom_drawer.dart';
import 'package:our_flutter_team/Widgets/custom_functions.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/screen/Activities/Class_Links/class_link_page.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import 'package:our_flutter_team/screen/students_activity_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Activities/Assignment/assignment_list_page.dart';

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
      uId = prefs.getString("uid") ?? '';
      name = prefs.getString("name") ?? '';
      email = prefs.getString("email") ?? '';
      institute = prefs.getString("institute") ?? '';
      profile = prefs.getString("img") ?? '';
      batch = prefs.getString("batchNumber") ?? '';
      phn = prefs.getString("phone") ?? '';
      batchID = prefs.getString('batchID') ?? '';
    });
    print("____ $uId  _$name  $email");
  }
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() async{
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
        return  onWillPop();
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        endDrawer:
            CustomDrawer(name: name, phn: phn, img: profile, email: email),
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent.shade700,
          title: const Text("Flutter Team"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                              uid: uId,
                              email: email,
                              institute: institute,
                              name: name,
                              img: profile,
                              phn: phn),),
                    );
                  },
                  child: Card(
                    color: Colors.cyanAccent.withOpacity(.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(profile),
                                radius: 30,)),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.toString(),
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
                SizedBox(
                  height: 150,
                  child: Card(
                    color: Colors.cyanAccent.withOpacity(.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.cyanAccent.withOpacity(.6),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Batch : 1 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Code :   20230502 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
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
                                                  uid: snapshot
                                                      .data![index].uniqueKey
                                                      .toString(),
                                                  email: snapshot
                                                      .data![index].email
                                                      .toString(),
                                                  institute: snapshot
                                                      .data![index]
                                                      .instituteName
                                                      .toString(),
                                                  name: snapshot
                                                      .data![index].studentName
                                                      .toString(),
                                                  img: snapshot
                                                      .data![index].pictureUrl
                                                      .toString(),
                                                  phn: snapshot.data![index]
                                                      .studentContact
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            color: Colors.cyanAccent.shade700,
                                            child: SizedBox(
                                              width: 80,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 3,
                                                    left: 5,
                                                    right: 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 70,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .pictureUrl
                                                                      .toString()))),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .studentName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Card(
                    color: Colors.cyanAccent.withOpacity(.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.cyanAccent.withOpacity(.6),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Batch : 2 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Code :   20230825 ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
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
                                                  uid: snapshot
                                                      .data![index].uniqueKey
                                                      .toString(),
                                                  email: snapshot
                                                      .data![index].email
                                                      .toString(),
                                                  institute: snapshot
                                                      .data![index]
                                                      .instituteName
                                                      .toString(),
                                                  name: snapshot
                                                      .data![index].studentName
                                                      .toString(),
                                                  img: snapshot
                                                      .data![index].pictureUrl
                                                      .toString(),
                                                  phn: snapshot.data![index]
                                                      .studentContact
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            color: Colors.cyanAccent.shade700,
                                            child: SizedBox(
                                              width: 80,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 3,
                                                    left: 5,
                                                    right: 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 70,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .pictureUrl
                                                                      .toString()))),
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .studentName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
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
                      ],
                    ),
                  ),
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
                        if (batch == "1") {
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
                          ),),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ClassLinkPage()));
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
                          )),
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
    );
  }

  Future openUrl(String url) async {
    try {
      if (await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {
      } else {
        print('#1: Could not launch $url');
      }
    } catch (e) {
      print('#2: Could not launch $url');
    }
  }
}
