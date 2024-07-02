class SendOtpModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  Data? data;

  SendOtpModel({this.statusCode, this.isSuccess, this.message, this.data});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['isSuccess'] = isSuccess;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? mobileNo;
  String? otpNo;
  String? message;

  Data({this.mobileNo, this.otpNo, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobileNo'];
    otpNo = json['otpNo'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileNo'] = mobileNo;
    data['otpNo'] = otpNo;
    data['message'] = message;
    return data;
  }
}
