class EventListModel {
  DateTime? date;
  String? eventCount;

  EventListModel({this.date, this.eventCount});

  EventListModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    eventCount = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['date'] = data;
    data['count'] = eventCount;
    return data;
  }
}
