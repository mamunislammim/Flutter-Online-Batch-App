import 'package:flutter/material.dart';
import 'package:our_flutter_team/Common%20Files/app_colors.dart';
import '../../../controller/all_api_controller.dart';
import '../../../models/assignment_submit_model.dart';
 import '../../view_full_image.dart';
import 'assignment_submit_page.dart';

class AssignmentDetailsPage extends StatefulWidget {
  const AssignmentDetailsPage(
      {super.key,
      required this.text,
      required this.image,
      required this.dateTimes,
      required this.startDate,
      required this.endDate,required this.marks});
  final String? image;
  final String? text;
  final String? dateTimes;
  final String? startDate;
  final String? endDate;
  final String? marks;

  @override
  State<AssignmentDetailsPage> createState() => _AssignmentDetailsPageState();
}

class _AssignmentDetailsPageState extends State<AssignmentDetailsPage> {
  bool checkDT = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgColor.withOpacity(.2),
      appBar: AppBar(
        backgroundColor: appBarColor,
        title:   const Text("Assignment Submission"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundColor: buttonColor.withOpacity(.5),
              child: Text(widget.marks.toString()),
            ),
          )
        ],
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageSeen(
                                imgUrl: widget.image.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 110,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: cardColor,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.image.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: SelectableText(
                          widget.text.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            FutureBuilder(
                future: GetAllData()
                    .assignmentSubmitImages(widget.dateTimes.toString()),
                builder: (_, snapshots) {
                  if (snapshots.hasData) {
                    List<AssignmentDataModel> datasnapData =
                        snapshots.data!.toList();
                    return GridView.builder(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshots.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .80,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        DateTime? start =
                            DateTime.tryParse(widget.startDate.toString());
                        DateTime? end =
                            DateTime.tryParse(widget.endDate.toString());
                        DateTime? submitTime = DateTime.tryParse(
                            snapshots.data![index].dateTime.toString());
                        checkDT = submitTime!.isAfter(start!) &&
                            submitTime.isBefore(end!);
                        return Card(
                         // color: Colors.grey.shade300,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageSeen(
                                        imgUrl: datasnapData[index]
                                            .pictureUrl
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 133,
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
                              Container(
                                color: checkDT == true
                                    ? const Color(0xff44d585)
                                    : const Color(0xffff9999),
                                padding: const EdgeInsets.only(
                                    top: 5, left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      datasnapData[index].name!.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "ID :",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          datasnapData[index]
                                              .batchID!
                                              .toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Date: ",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          datasnapData[index]
                                              .dateTime!
                                              .substring(0, 10)
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Time: ",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          datasnapData[index]
                                              .dateTime!
                                              .substring(10, 19)
                                              .toString(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
        backgroundColor: buttonColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignmentSubmitScreen(
                uniqueKey: widget.dateTimes,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
