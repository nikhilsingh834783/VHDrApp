class SurgeryModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<SurgeryListData>? data;

  SurgeryModel({this.statusCode, this.isSuccess, this.message, this.data});

  SurgeryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <SurgeryListData>[];
        json['data'].forEach((v) {
          data!.add(SurgeryListData.fromJson(v));
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

class SurgeryListData {
  String? operationName;
  double? testRate;

  SurgeryListData({this.operationName, this.testRate});

  SurgeryListData.fromJson(Map<String, dynamic> json) {
    operationName = json['operationName'];
    testRate = json['testRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['operationName'] = operationName;
    data['testRate'] = testRate;
    return data;
  }
}
