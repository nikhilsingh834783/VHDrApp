class AppointmentsModels {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<AppointMentListData>? data;

  AppointmentsModels(
      {this.statusCode, this.isSuccess, this.message, this.data});

  AppointmentsModels.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <AppointMentListData>[];
        json['data'].forEach((v) {
          data!.add(AppointMentListData.fromJson(v));
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

class AppointMentListData {
  String? isValidToken;
  String? appDate;
  String? caseNo;
  String? patientName;
  String? caseType;
  String? appTime;
  String? uhid;

  AppointMentListData(
      {this.isValidToken,
      this.appDate,
      this.caseNo,
      this.patientName,
      this.caseType,
      this.appTime,
      this.uhid});

  AppointMentListData.fromJson(Map<String, dynamic> json) {
    isValidToken = json['isValidToken'];
    appDate = json['appDate'];
    caseNo = json['caseNo'];
    patientName = json['patientName'];
    caseType = json['caseType'];
    appTime = json['appTime'];
    uhid = json['uhid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValidToken'] = isValidToken;
    data['appDate'] = appDate;
    data['caseNo'] = caseNo;
    data['patientName'] = patientName;
    data['caseType'] = caseType;
    data['appTime'] = appTime;
    data['uhid'] = uhid;
    return data;
  }
}
