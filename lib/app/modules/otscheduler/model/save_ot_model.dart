class SaveOtModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  Data? data;

  SaveOtModel({this.statusCode, this.isSuccess, this.message, this.data});

  SaveOtModel.fromJson(Map<String, dynamic> json) {
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
  String? savedYN;

  Data({this.savedYN});

  Data.fromJson(Map<String, dynamic> json) {
    savedYN = json['savedYN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['savedYN'] = savedYN;
    return data;
  }
}
