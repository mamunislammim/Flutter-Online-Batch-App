class SignUpModel {
  String? studentName;
  String? instituteName;
  String? studentContact;
  String? pictureUrl;
  String? email;
  String? uniqueKey;
  String? batchNo;

  SignUpModel(
      { required this.studentName,
        required this.studentContact,
        required this.email,
        required this.instituteName,
        required this.uniqueKey,
        required this.pictureUrl,
      required this.batchNo});
  SignUpModel.fromJson(dynamic json) {
    studentName = json['studentName'];
    instituteName = json['instituteName'];
    uniqueKey = json['uniqueKey'];
    email = json['email'];
    studentContact = json['studentContact'];
    pictureUrl = json['pictureUrl'];
    batchNo = json['batchNo'];
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