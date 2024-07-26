class AdditionalSurgeonModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<AdditionalDoctorList>? data;

  AdditionalSurgeonModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  AdditionalSurgeonModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <AdditionalDoctorList>[];
        json['data'].forEach((v) {
          data!.add(AdditionalDoctorList.fromJson(v));
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

class AdditionalDoctorList {
  int? docId;
  String? docName;

  AdditionalDoctorList({this.docId, this.docName});

  AdditionalDoctorList.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    docName = json['docName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docId'] = docId;
    data['docName'] = docName;
    return data;
  }
}
