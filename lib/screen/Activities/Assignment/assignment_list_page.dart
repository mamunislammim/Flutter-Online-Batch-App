import 'package:flutter/material.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/screen/Activities/Assignment/assignment_details_page.dart';
import 'package:our_flutter_team/screen/Activities/Assignment/assignment_question_submit_page.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import '../../../Common Files/app_colors.dart';
import '../../../models/assignment_question_submit_model.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  State<AssignmentListPage> createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  DateTime? nowDT;
  bool checkDT = false;
  showDT() async {
    nowDT = DateTime.now();
  }

  @override
  void initState() {
    showDT();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.shade700,
        title: const Text("Assignment"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: GetAllData().assignmentQuestionData(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<AssignmentQsnSubmitModel> a = snapshot.data!.toList();
              List<AssignmentQsnSubmitModel> data = a.reversed.toList();
              return ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var startDate =
                        DateTime.tryParse(data[index].startDT.toString());
                    var endDate =
                        DateTime.tryParse(data[index].endDT.toString());
                    if (nowDT != null) {
                      checkDT = nowDT!.isAfter(startDate!) &&
                          nowDT!.isBefore(endDate!);
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssignmentDetailsPage(
                              text: data[index].text,
                              image: data[index].pictureUrl,
                              dateTimes: data[index].dateTime,
                              startDate: startDate.toString(),
                              endDate: endDate.toString(),
                              marks: data[index].marks,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: checkDT == true
                            ? const Color(0xff44d585)
                            : const Color(0xffff9999),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Center(
                                      child: Icon(
                                    Icons.file_copy,
                                    color: Colors.white.withOpacity(.8),
                                  ))),
                              Expanded(
                                flex: 14,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].text.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Start :   ${startDate.toString().substring(0, 11)}    ${startDate.toString().substring(11, 16)}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff18683c),
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "Start :   ${endDate.toString().substring(0, 11)}    ${endDate.toString().substring(11, 16)}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff18683c),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Center(
                                    child: Card(
                                  color: checkDT == true
                                      ? const Color(0xff36c174)
                                      : const Color(0xffff9985),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Marks",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(.8)),
                                        ),
                                        Text(
                                           data[index].marks.toString(),
                                          style: TextStyle(
                                              color:
                                              Colors.white.withOpacity(.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text("Please Contact with Developer"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: myPhn == '01761810531'
          ? FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AssignmentQuestionSubmitScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : const Text(""),
    );
  }
}
