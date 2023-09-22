
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../models/all_models.dart';
import '../screen/splash_screen.dart';

class GetAllData{
  Future<List<ImageSubmitModel>>  getInformation(String uid, String batch)async{
    List<ImageSubmitModel> data = [];
    await FirebaseDatabase.instance.ref('Batch_${batch}_image').child(uid).orderByKey().get().then((value) {
      for (var d in value.children) {
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
    await FirebaseDatabase.instance.ref('Assignment_Question_Batch_$batch').orderByKey().get().then((value) {
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
    await FirebaseDatabase.instance.ref('Assignment_submit_$batch').child(dates).orderByKey().get().then((value) {
      for (var d in value.children) {
        print("____>>>>>>>>>>>________ ${d.value}");
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
        print("${data.length}");
      }
    }
    );
    return data;
  }

}