class SignUpModel {
  String? studentName;
  String? instituteName;
  String? studentContact;
  String? pictureUrl;
  String? email;
  String? uniqueKey;
  String? batchNo;
  String? batchID;

  SignUpModel(
      { required this.studentName,
        required this.studentContact,
        required this.email,
        required this.instituteName,
        required this.uniqueKey,
        required this.pictureUrl,
      required this.batchNo,
      required this.batchID
      });
  SignUpModel.fromJson(dynamic json) {
    studentName = json['studentName'];
    instituteName = json['instituteName'];
    uniqueKey = json['uniqueKey'];
    email = json['email'];
    studentContact = json['studentContact'];
    pictureUrl = json['pictureUrl'];
    batchNo = json['batchNo'];
    batchID = json['batchID'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['studentName'] = studentName;
    map['email'] = email;
    map['instituteName'] = instituteName;
    map['uniqueKey'] = uniqueKey;
    map['studentContact'] = studentContact;
    map['pictureUrl'] = pictureUrl;
    map['batchNo'] = batchNo;
    map['batchID'] = batchID;
    return map;
  }
}

class ImageSubmitModel {
  String? pictureUrl;
  String? dateTime;
  String? uniqueKey;

  ImageSubmitModel(
      {required this.dateTime,
        required this.uniqueKey,
        required this.pictureUrl});
  ImageSubmitModel.fromJson(dynamic json) {
    uniqueKey = json['uniqueKey'];
    dateTime = json['dateTime'];
    pictureUrl = json['pictureUrl'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uniqueKey'] = uniqueKey;
    map['dateTime'] = dateTime;
    map['pictureUrl'] = pictureUrl;
    return map;
  }
}

class AssignmentQsnSubmitModel {
  String? pictureUrl;
  String? dateTime;
  String? uniqueKey;
  String? text;

  AssignmentQsnSubmitModel(
      {required this.dateTime,
        required this.uniqueKey,
        required this.pictureUrl,
      required this.text});
  AssignmentQsnSubmitModel.fromJson(dynamic json) {
    uniqueKey = json['uniqueKey'];
    dateTime = json['dateTime'];
    pictureUrl = json['pictureUrl'];
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uniqueKey'] = uniqueKey;
    map['dateTime'] = dateTime;
    map['pictureUrl'] = pictureUrl;
    map['text'] = text;
    return map;
  }
}

class AssignmentDataModel {
  String? pictureUrl;
  String? dateTime;
  String? uniqueKey;
  String? name;
  String? batchID;

  AssignmentDataModel(
      {required this.dateTime,
        required this.uniqueKey,
        required this.pictureUrl,required this.name,required this.batchID});
  AssignmentDataModel.fromJson(dynamic json) {
    uniqueKey = json['uniqueKey'];
    dateTime = json['dateTime'];
    pictureUrl = json['pictureUrl'];
    name = json['name'];
    batchID = json['batchID'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uniqueKey'] = uniqueKey;
    map['dateTime'] = dateTime;
    map['pictureUrl'] = pictureUrl;
    map['name'] = name;
    map['batchID'] = batchID;
    return map;
  }
}