import 'package:flutter/material.dart';
import 'package:our_flutter_team/Widgets/custom_functions.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassLinkPage extends StatefulWidget {
  const ClassLinkPage({super.key});

  @override
  State<ClassLinkPage> createState() => _ClassLinkPageState();
}

class _ClassLinkPageState extends State<ClassLinkPage> {
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.5),
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
              Card(
                color: const Color(0xffffd0a1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $name",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Today you have group class. Please, attend class on time.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Class Start : ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      const Text(
                        "Class Start : ",
                        style: TextStyle(
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
              Card(
                color: Colors.blueGrey,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
                child: GestureDetector(
                  onTap: () {
                    openUrl('https://meet.google.com');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Join Class",
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
              const SizedBox(
                height: 30,
              ),
              phn == "01761810531"
                  ? Card(
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
                          Card(
                            color: Colors.blueGrey,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            child: GestureDetector(
                              onTap: () {},
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
                    )
                  : const Text(""),
            ],
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
        showToast("Could not launch", Colors.red);
        print('#1: Could not launch $url');
      }
    } catch (e) {
      showToast("Could not launch", Colors.red);
      print('#2: Could not launch $url');
    }
  }
}
