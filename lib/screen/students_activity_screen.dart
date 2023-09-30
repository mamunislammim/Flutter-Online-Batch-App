import 'package:flutter/material.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import 'package:our_flutter_team/screen/view_full_image.dart';
import '../controller/all_api_controller.dart';
import 'image_submit_screen.dart';

class StudentsActivityScreen extends StatefulWidget {
  const StudentsActivityScreen(
      {Key? key,
      required this.uid,
      required this.email,
      required this.institute,
      required this.name,
      required this.img,
      required this.phn,
      required this.batch,
      required this.batchID})
      : super(key: key);
  final String uid;
  final String name;
  final String email;
  final String institute;
  final String phn;
  final String img;
  final String batch;
  final String batchID;
  @override
  State<StudentsActivityScreen> createState() => _StudentsActivityScreenState();
}

class _StudentsActivityScreenState extends State<StudentsActivityScreen> {
  String? name;
  String? email;
  String? phn;
  String? institute;
  String? img;
  String? uid;
  @override
  void initState() {
    uid = widget.uid;
    name = widget.name;
    email = widget.email;
    phn = widget.phn;
    institute = widget.institute;
    img = widget.img;
    setState(() {});
    print("____11____ $myUID   $uid");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: size.height * .17,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('asset/image/bgi.png'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -50,
                      left: 10,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: img != null
                            ? NetworkImage(img.toString())
                            : const NetworkImage(
                                "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png"),
                      )),
                  Positioned(
                    top: (size.height * .17),
                    left: (size.width * .33),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          institute.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          email.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          "Batch : ${widget.batch}          Batch ID : ${widget.batchID}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * .1,
              ),
              Card(
                color: Colors.blueGrey.shade100,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Activities",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: GetAllData().getInformation(widget.uid, widget.batch),
                  builder: (_, snapshots) {
                    if (snapshots.hasData) {
                      var snapData = snapshots.data;
                      // snapData!.reversed;
                      return GridView.builder(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        // itemCount: snapshots.data!.length,
                        itemCount: snapshots.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .70,
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.grey.shade300,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageSeen(
                                          imgUrl: snapshots
                                              .data![index].pictureUrl
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(snapData![index]
                                            .pictureUrl
                                            .toString()),
                                        //  image: AssetImage('asset/image/login.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(snapData[index]
                                        .dateTime!
                                        .substring(0, 10)
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Time: ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(snapData[index]
                                        .dateTime!
                                        .substring(10, 19)
                                        .toString())
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: myUID == widget.uid ? GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageSubmitScreen(
                uniqueKey: myUID.toString(),
              ),
            ),
          );
        },
        child: const CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: 30,
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ) : const SizedBox(),
    );
  }
}
