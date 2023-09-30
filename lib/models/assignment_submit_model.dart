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