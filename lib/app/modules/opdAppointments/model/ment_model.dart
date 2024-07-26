class AppointmentsDateModels {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<AppointMentLsitData>? data;

  AppointmentsDateModels(
      {this.statusCode, this.isSuccess, this.message, this.data});

  AppointmentsDateModels.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <AppointMentLsitData>[];
        json['data'].forEach((v) {
          data!.add(AppointMentLsitData.fromJson(v));
        });
      } else {
        data = [];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointMentLsitData {
  String? selectedDate;
  int? cnt;

  AppointMentLsitData({this.selectedDate, this.cnt});

  AppointMentLsitData.fromJson(Map<String, dynamic> json) {
    selectedDate = json['selectedDate'];
    cnt = json['cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selectedDate'] = selectedDate;
    data['cnt'] = cnt;
    return data;
  }
}
