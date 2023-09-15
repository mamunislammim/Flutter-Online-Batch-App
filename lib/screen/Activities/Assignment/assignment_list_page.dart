import 'package:flutter/material.dart';
import 'package:our_flutter_team/controller/all_api_controller.dart';
import 'package:our_flutter_team/screen/Activities/Assignment/assignment_details_page.dart';
import 'package:our_flutter_team/screen/Activities/Assignment/assignment_question_submit_page.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';

import '../../../models/all_models.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  State<AssignmentListPage> createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
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
                padding: EdgeInsets.all(5),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AssignmentDetailsPage(text: data[index].text, image: data[index].pictureUrl, dateTimes: data[index].dateTime)));
                      },
                      child: Card(
                        color: Colors.cyanAccent.withOpacity(.5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(child: Icon(Icons.file_copy,color: Colors.white.withOpacity(.8),))),
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
                                          fontSize: 16,
                                          color: Colors.white, fontWeight: FontWeight.w400),
                                    ),
                                    Text("Start Time : ",maxLines: 2,overflow: TextOverflow.ellipsis,),
                                    Text("End Time : ",maxLines: 2,overflow: TextOverflow.ellipsis,)
                                  ],
                                ),
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
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: phn == '01761810531'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AssignmentQuestionSubmitScreen(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : Text(""),
    );
  }
}
