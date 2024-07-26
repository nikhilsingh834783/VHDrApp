class DoctorVisitModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<DoctorVisitListData>? data;

  DoctorVisitModel({this.statusCode, this.isSuccess, this.message, this.data});

  DoctorVisitModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <DoctorVisitListData>[];
        json['data'].forEach((v) {
          data!.add(DoctorVisitListData.fromJson(v));
        });
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

class DoctorVisitListData {
  String? serviceName;
  String? eAC;
  String? preMEAC;
  String? semispl;
  String? spl;
  String? deluxe;
  String? suite;

  DoctorVisitListData(
      {this.serviceName,
      this.eAC,
      this.preMEAC,
      this.semispl,
      this.spl,
      this.deluxe,
      this.suite});

  DoctorVisitListData.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    eAC = json['e_AC'];
    preMEAC = json['preM_E_AC'];
    semispl = json['semispl'];
    spl = json['spl'];
    deluxe = json['deluxe'];
    suite = json['suite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceName'] = serviceName;
    data['e_AC'] = eAC;
    data['preM_E_AC'] = preMEAC;
    data['semispl'] = semispl;
    data['spl'] = spl;
    data['deluxe'] = deluxe;
    data['suite'] = suite;
    return data;
  }
}
