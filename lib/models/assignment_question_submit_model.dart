class AssignmentQsnSubmitModel {
  String? pictureUrl;
  String? dateTime;
  String? uniqueKey;
  String? text;
  String? startDT;
  String? endDT;
  String? marks;

  AssignmentQsnSubmitModel(
      {required this.dateTime,
        required this.uniqueKey,
        required this.pictureUrl,
        required this.text,
        required this.startDT,
        required this.endDT,
        required this.marks
      });
  AssignmentQsnSubmitModel.fromJson(dynamic json) {
    uniqueKey = json['uniqueKey'];
    dateTime = json['dateTime'];
    pictureUrl = json['pictureUrl'];
    text = json['text'];
    startDT = json['startDT'];
    endDT = json['endDT'];
    marks = json['marks'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uniqueKey'] = uniqueKey;
    map['dateTime'] = dateTime;
    map['pictureUrl'] = pictureUrl;
    map['text'] = text;
    map['startDT'] = startDT;
    map['endDT'] = endDT;
    map['marks'] = marks;
    return map;
  }
}