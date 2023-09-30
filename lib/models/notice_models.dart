class NoticeModel {
  String? notice;
  String? submitTime;
  NoticeModel({required this.notice, required this.submitTime});

  NoticeModel.fromJson(dynamic json) {
    notice = json['notice'];
    submitTime = json['submitTime'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notice'] = notice;
    map['submitTime'] = submitTime;
    return map;
  }
}
