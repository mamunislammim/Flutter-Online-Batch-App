import 'package:flutter/material.dart';
import 'package:our_flutter_team/Common%20Files/app_colors.dart';
import 'package:our_flutter_team/screen/splash_screen.dart';
import '../../../controller/all_api_controller.dart';
import '../../../models/all_models.dart';
import '../../students_activity_screen.dart';
import '../../view_full_image.dart';
import 'assignment_submit_page.dart';

class AssignmentDetailsPage extends StatefulWidget {
  const AssignmentDetailsPage(
      {super.key, required this.text, required this.image,required this.dateTimes});
  final String? image;
  final String? text;
  final String? dateTimes;

  @override
  State<AssignmentDetailsPage> createState() => _AssignmentDetailsPageState();
}

class _AssignmentDetailsPageState extends State<AssignmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent.shade700,
        title: const Text("Assignment Submission"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(7),
        child: Column(
          children: [
            Card(
              color: cardColor,
              child: SizedBox(
                height: 120,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageSeen(imgUrl: widget.image.toString(),)));
                        },
                        child: Container(
                          height: 110,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: cardColor,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.image.toString()))),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                        Flexible(
                          child: SelectableText(widget.text.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            FutureBuilder(
                future: GetAllData().assignmentSubmitImages(widget.dateTimes.toString()),
                builder: (_, snapshots) {
                  if (snapshots.hasData) {
                    List<AssignmentDataModel> datasnapData = snapshots.data!.toList();
                     return GridView.builder(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: snapshots.data!.length,
                      itemCount: snapshots.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .80,
                        crossAxisCount: 2,
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
                                        imgUrl:
                                            datasnapData[index].pictureUrl
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(datasnapData[index]
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
                                  Text(datasnapData[index]
                                      .name!
                                      .toString(),
                                  maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Date: ",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(datasnapData[index]
                                      .dateTime!
                                      .substring(0, 10)
                                      .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(datasnapData[index].uniqueKey!.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Time: ",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Text(datasnapData[index]
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  AssignmentSubmitScreen(uniqueKey: widget.dateTimes,),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
