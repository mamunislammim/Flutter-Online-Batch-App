import 'package:flutter/material.dart';
import 'package:our_flutter_team/Widgets/custom_drawer.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import 'package:our_flutter_team/screen/students_activity_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'image_submit_screen.dart';

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
    });
    print("____ $uId  _$name  $email");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade700,
        endDrawer: CustomDrawer(name: name, phn: phn, img: profile, email: email),
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
                Card(
                  color: Colors.cyanAccent.withOpacity(.5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 3,
                          child: CircleAvatar(
                            radius: 30,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
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
                FutureBuilder(
                    future: GetAllData().getUserInfo('1'),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 105,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentsActivityScreen(
                                              uid: snapshot.data![index].uniqueKey
                                                  .toString(),
                                              email: snapshot.data![index].email
                                                  .toString(),
                                              institute: snapshot
                                                  .data![index].instituteName
                                                  .toString(),
                                              name: snapshot.data![index].studentName
                                                  .toString(),
                                              img: snapshot.data![index].pictureUrl
                                                  .toString(),
                                              phn: snapshot
                                                  .data![index].studentContact
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
                                            top: 5, bottom: 3, left: 5, right: 5),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 70,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(snapshot
                                                          .data![index].pictureUrl
                                                          .toString()))),
                                            ),
                                            Text(
                                              snapshot.data![index].studentName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
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
                FutureBuilder(
                    future: GetAllData().getUserInfo('2'),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                      return SizedBox(
                        height: 105,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StudentsActivityScreen(
                                            uid: snapshot.data![index].uniqueKey
                                                .toString(),
                                            email: snapshot.data![index].email
                                                .toString(),
                                            institute: snapshot
                                                .data![index].instituteName
                                                .toString(),
                                            name: snapshot.data![index].studentName
                                                .toString(),
                                            img: snapshot.data![index].pictureUrl
                                                .toString(),
                                            phn: snapshot
                                                .data![index].studentContact
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
                                          top: 5, bottom: 3, left: 5, right: 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data![index].pictureUrl
                                                        .toString()))),
                                          ),
                                          Text(
                                            snapshot.data![index].studentName
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
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

              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageSubmitScreen(
                  uniqueKey: uId.toString(),
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
        ),
      ),
    );
  }
}
