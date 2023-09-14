
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import '../models/all_models.dart';
import '../screen/splash_screen.dart';

class GetAllData{
  Future<List<ImageSubmitModel>>  getInformation(String uid)async{
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