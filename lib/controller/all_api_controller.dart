
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:our_flutter_team/models/class_link_models.dart';
import 'package:our_flutter_team/models/notice_models.dart';
import '../models/assignment_question_submit_model.dart';
import '../models/assignment_submit_model.dart';
import '../models/image_submit_model.dart';
import '../models/sign_up_models.dart';
 import '../screen/splash_screen.dart';

class GetAllData{
  Future<List<ImageSubmitModel>>  getInformation(String uid, String batch)async{
    List<ImageSubmitModel> data = [];
    print("_____$batch  $uid ________ ");
    await FirebaseDatabase.instance.ref('Batch_${batch}_image').child(uid).orderByKey().get().then((value) {
      for (var d in value.children) {
        print("_____________ ");
        data.add(
          ImageSubmitModel.fromJson(jsonDecode(jsonEncode(d.value))),
        );
      }
    }
    );
    return data;
  }

  Future<List<AssignmentQsnSubmitModel>>  assignmentQuestionData()async{
    List<AssignmentQsnSubmitModel> data = [];
    await FirebaseDatabase.instance.ref('Assignment_Question_Batch_$myBatch').orderByKey().get().then((value) {
      for (var d in value.children) {
        data.add(
          AssignmentQsnSubmitModel.fromJson(jsonDecode(jsonEncode(d.value))),
        );
      }
    }
    );
    return data;
  }

  Future<List<AssignmentDataModel>>  assignmentSubmitImages(String dates)async{
    List<AssignmentDataModel> data = [];
    await FirebaseDatabase.instance.ref('Assignment_submit_$myBatch').child(dates).orderByKey().get().then((value) {
      for (var d in value.children) {
         data.add(
          AssignmentDataModel.fromJson(jsonDecode(jsonEncode(d.value))),
        );
      }
    }
    );
    return data;
  }

  Future<List<SignUpModel>> getUserInfo(String batchNumber)async{
    List<SignUpModel> data = [];
    await FirebaseDatabase.instance.ref('Batch_$batchNumber').orderByKey().get().then((value) {
      for (var d in value.children) {
        data.add(
          SignUpModel.fromJson(jsonDecode(jsonEncode(d.value))),
        );
       }
    }
    );
    return data;
  }

  Future<List<ClassLinkModels>> getClassLink(String batchNumber)async{
    List<ClassLinkModels> data = [];
    await FirebaseDatabase.instance.ref("Class_Link_Batch_$batchNumber").orderByKey().get().then((value) {
      for (var d in value.children) {
        data.add(
          ClassLinkModels.fromJson(jsonDecode(jsonEncode(d.value))),
        );
      }
    }
    );
    return data;
  }

  Future<List<NoticeModel>> noticeApi()async{
    List<NoticeModel> data = [];
    await FirebaseDatabase.instance.ref("Notice_Batch_$myBatch").orderByKey().get().then((value) {
      for (var d in value.children) {
        data.add(
          NoticeModel.fromJson(jsonDecode(jsonEncode(d.value))),
        );
      }
    }
    );
    return data;
  }

}