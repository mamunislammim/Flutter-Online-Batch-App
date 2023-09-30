
class ClassLinkModels{
  String? url;
  String? startTime;
  String? endTime;
  ClassLinkModels({required this.url, required this.startTime, required this.endTime});

  ClassLinkModels.fromJson(dynamic json) {
    url = json['url'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    return map;
  }
}