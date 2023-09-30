class SignUpModel {
  String? studentName;
  String? instituteName;
  String? studentContact;
  String? pictureUrl;
  String? email;
  String? password;
  String? uniqueID;
  String? batchNo;
  String? batchID;

  SignUpModel(
      { required this.studentName,
        required this.studentContact,
        required this.email,
        required this.instituteName,
        required this.password,
        required this.pictureUrl,
        required this.batchNo,
        required this.batchID,
        required this.uniqueID
      });
  SignUpModel.fromJson(dynamic json) {
    studentName = json['studentName'];
    instituteName = json['instituteName'];
    password = json['password'];
    email = json['email'];
    studentContact = json['studentContact'];
    pictureUrl = json['pictureUrl'];
    batchNo = json['batchNo'];
    batchID = json['batchID'];
    uniqueID = json['uniqueID'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['studentName'] = studentName;
    map['email'] = email;
    map['instituteName'] = instituteName;
    map['password'] = password;
    map['studentContact'] = studentContact;
    map['pictureUrl'] = pictureUrl;
    map['batchNo'] = batchNo;
    map['batchID'] = batchID;
    map['uniqueID'] = uniqueID;
    return map;
  }
}
