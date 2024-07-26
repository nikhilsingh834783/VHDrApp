class RadioLogyModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<RadioLogyList>? data;

  RadioLogyModel({this.statusCode, this.isSuccess, this.message, this.data});

  RadioLogyModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <RadioLogyList>[];
        json['data'].forEach((v) {
          data!.add(RadioLogyList.fromJson(v));
        });
      } else {
        [];
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

class RadioLogyList {
  String? rptDate;
  String? patientName;
  String? ipdNo;
  String? uhid;
  String? bedNo;
  int? testId;
  String? testName;
  String? reportURL;

  RadioLogyList(
      {this.rptDate,
      this.patientName,
      this.ipdNo,
      this.uhid,
      this.bedNo,
      this.testId,
      this.testName,
      this.reportURL});

  RadioLogyList.fromJson(Map<String, dynamic> json) {
    rptDate = json['rptDate'];
    patientName = json['patientName'];
    ipdNo = json['ipdNo'];
    uhid = json['uhid'];
    bedNo = json['bedNo'];
    testId = json['testId'];
    testName = json['testName'];
    reportURL = json['reportURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rptDate'] = rptDate;
    data['patientName'] = patientName;
    data['ipdNo'] = ipdNo;
    data['uhid'] = uhid;
    data['bedNo'] = bedNo;
    data['testId'] = testId;
    data['testName'] = testName;
    data['reportURL'] = reportURL;
    return data;
  }
}
