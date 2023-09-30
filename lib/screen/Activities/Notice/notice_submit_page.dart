import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:our_flutter_team/models/notice_models.dart';
import '../../splash_screen.dart';

class NoticeCreatePage extends StatefulWidget {
  const NoticeCreatePage({super.key});

  @override
  State<NoticeCreatePage> createState() => _NoticeCreatePageState();
}

class _NoticeCreatePageState extends State<NoticeCreatePage> {
  final TextEditingController _noticeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(15)
                  ),
                  controller: _noticeController,
                  maxLines: 10,
                ),
              ),
              ElevatedButton(
                  onPressed: ()async{
                    var dt = DateTime.now().toString().replaceAll("-","_").replaceAll(" ","_").replaceAll(":","_").substring(0,19);
                     EasyLoading.show(status: "Uploading");
                    var model = NoticeModel(notice: _noticeController.text, submitTime: DateTime.now().toString());
                    await FirebaseDatabase.instance.ref("Notice_Batch_$myBatch").child(dt.toString()).set(model.toJson());
                    EasyLoading.showSuccess("Done");
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
