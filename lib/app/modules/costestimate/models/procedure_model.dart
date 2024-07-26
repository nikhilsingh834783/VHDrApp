class ProcedureModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<ProcedureListData>? data;

  ProcedureModel({this.statusCode, this.isSuccess, this.message, this.data});

  ProcedureModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <ProcedureListData>[];
        json['data'].forEach((v) {
          data!.add(ProcedureListData.fromJson(v));
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

class ProcedureListData {
  String? operationName;
  String? testName;
  double? testRate;

  ProcedureListData({this.operationName, this.testName, this.testRate});

  ProcedureListData.fromJson(Map<String, dynamic> json) {
    operationName = json['operationName'];
    testName = json['testName'];
    testRate = json['testRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['operationName'] = operationName;
    data['testName'] = testName;
    data['testRate'] = testRate;
    return data;
  }
}
