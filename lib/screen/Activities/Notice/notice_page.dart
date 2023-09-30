import 'package:flutter/material.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/models/notice_models.dart';
import 'package:our_flutter_team/screen/Activities/Notice/notice_submit_page.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';

import '../../../Common Files/app_colors.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text("Notice Board"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: GetAllData().noticeApi(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<NoticeModel> d = snapshot.data!.toList();
              List<NoticeModel> data = d.reversed.toList();
              return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Color(0xffccffff),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date : ${data[index].submitTime.toString().substring(0,11)}",
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Text(
                                      "Time : ${data[index].submitTime.toString().substring(11,16)}",
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              data[index].notice.toString(),
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something wrong"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: myPhn == "01761810531"
          ? FloatingActionButton(
        backgroundColor: buttonColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NoticeCreatePage()));
              },
              child: const Icon(
                Icons.add_circle_outline,
                size: 30,
              ),
            )
          : const SizedBox(),
    );
  }
}
