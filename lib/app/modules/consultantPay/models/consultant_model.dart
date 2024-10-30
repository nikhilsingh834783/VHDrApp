class ConsultantResponseModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<ConsultantListData>? data;

  ConsultantResponseModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  ConsultantResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <ConsultantListData>[];
        json['data'].forEach((v) {
          data!.add(ConsultantListData.fromJson(v));
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

class ConsultantListData {
  String? doctorName;
  String? monthYr;
  String? pendingYN;
  String? pendingAmount;
  String? payment;
  String? reportLinkURL;

  ConsultantListData(
      {this.doctorName,
      this.monthYr,
      this.pendingYN,
      this.pendingAmount,
      this.payment,
      this.reportLinkURL});

  ConsultantListData.fromJson(Map<String, dynamic> json) {
    doctorName = json['doctorName'];
    monthYr = json['monthYr'];
    pendingYN = json['pendingYN'];
    pendingAmount = json['pendingAmount'].toString();
    payment = json['payment'].toString();
    reportLinkURL = json['reportLinkURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorName'] = doctorName;
    data['monthYr'] = monthYr;
    data['pendingYN'] = pendingYN;
    data['pendingAmount'] = pendingAmount;
    data['payment'] = payment;
    data['reportLinkURL'] = reportLinkURL;
    return data;
  }
}
