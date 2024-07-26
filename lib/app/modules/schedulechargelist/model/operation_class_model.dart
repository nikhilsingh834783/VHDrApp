class OperationClassModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<OperationListData>? data;

  OperationClassModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  OperationClassModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <OperationListData>[];
        json['data'].forEach((v) {
          data!.add(OperationListData.fromJson(v));
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

class OperationListData {
  int? id;
  String? className;

  OperationListData({this.id, this.className});

  OperationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['className'] = className;
    return data;
  }
}
