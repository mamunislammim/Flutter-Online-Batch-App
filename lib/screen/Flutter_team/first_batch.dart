import 'package:flutter/material.dart';
import '../../controller/all_api_controller.dart';
import '../students_activity_screen.dart';

class FirstBatchScreen extends StatefulWidget {
  const FirstBatchScreen({super.key});

  @override
  State<FirstBatchScreen> createState() => _FirstBatchScreenState();
}

class _FirstBatchScreenState extends State<FirstBatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Batch"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: GetAllData().getUserInfo('1'),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 130,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentsActivityScreen(
                              uid: snapshot.data![index].uniqueKey.toString(),
                              email: snapshot.data![index].email.toString(),
                              institute: snapshot.data![index].instituteName
                                  .toString(),
                              name:
                                  snapshot.data![index].studentName.toString(),
                              img: snapshot.data![index].pictureUrl.toString(),
                              phn: snapshot.data![index].studentContact
                                  .toString(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.cyanAccent.shade700,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 3, left: 5, right: 5),
                          child: Column(
                            // mainAxisAlignment:
                            // MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 98,
                                width: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot
                                            .data![index].pictureUrl
                                            .toString()))),
                              ),
                              Text(
                                snapshot.data![index].studentName.toString(),
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
    );
  }
}
