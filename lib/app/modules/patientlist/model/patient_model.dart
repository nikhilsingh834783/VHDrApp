// class PatientListModel {
//   String? isValidToken;
//   String? patientCategory;
//   String? uhid;
//   String? ipdNo;
//   String? patientName;
//   String? bedNo;
//   String? ward;
//   String? floor;
//   String? doa;
//   String? admType;
//   String? totalDays;
//   String? referredDr;

//   PatientListModel(
//       {this.isValidToken,
//       this.patientCategory,
//       this.uhid,
//       this.ipdNo,
//       this.patientName,
//       this.bedNo,
//       this.ward,
//       this.floor,
//       this.doa,
//       this.admType,
//       this.totalDays,
//       this.referredDr});

//   PatientListModel.fromJson(Map<String, dynamic> json) {
//     isValidToken = json['isValidToken'];
//     patientCategory = json['patientCategory'];
//     uhid = json['uhid'];
//     ipdNo = json['ipdNo'];
//     patientName = json['patientName'];
//     bedNo = json['bedNo'];
//     ward = json['ward'];
//     floor = json['floor'];
//     doa = json['doa'];
//     admType = json['admType'];
//     totalDays = json['totalDays'];
//     referredDr = json['referredDr'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['isValidToken'] = isValidToken;
//     data['patientCategory'] = patientCategory;
//     data['uhid'] = uhid;
//     data['ipdNo'] = ipdNo;
//     data['patientName'] = patientName;
//     data['bedNo'] = bedNo;
//     data['ward'] = ward;
//     data['floor'] = floor;
//     data['doa'] = doa;
//     data['admType'] = admType;
//     data['totalDays'] = totalDays;
//     data['referredDr'] = referredDr;
//     return data;
//   }
// }

class PatientResponseModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<PatientListModel>? data;

  PatientResponseModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  PatientResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null && json['data'].runtimeType == List<dynamic>) {
      data = <PatientListModel>[];
      json['data'].forEach((v) {
        data!.add(PatientListModel.fromJson(v));
      });
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

class PatientListModel {
  String? isValidToken;
  String? patientCategory;
  String? uhid;
  String? ipdNo;
  String? patientName;
  String? bedNo;
  String? ward;
  String? floor;
  String? doa;
  String? admType;
  String? totalDays;
  String? mobiileNo;
  String? referredDr;

  PatientListModel(
      {this.isValidToken,
      this.patientCategory,
      this.uhid,
      this.ipdNo,
      this.patientName,
      this.bedNo,
      this.ward,
      this.floor,
      this.doa,
      this.admType,
      this.totalDays,
      this.mobiileNo,
      this.referredDr});

  PatientListModel.fromJson(Map<String, dynamic> json) {
    isValidToken = json['isValidToken'];
    patientCategory = json['patientCategory'];
    uhid = json['uhid'];
    ipdNo = json['ipdNo'];
    patientName = json['patientName'];
    bedNo = json['bedNo'];
    ward = json['ward'];
    floor = json['floor'];
    doa = json['doa'];
    admType = json['admType'];
    totalDays = json['totalDays'];
    mobiileNo = json['mobileNo'];
    referredDr = json['referredDr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValidToken'] = isValidToken;
    data['patientCategory'] = patientCategory;
    data['uhid'] = uhid;
    data['ipdNo'] = ipdNo;
    data['patientName'] = patientName;
    data['bedNo'] = bedNo;
    data['ward'] = ward;
    data['floor'] = floor;
    data['doa'] = doa;
    data['admType'] = admType;
    data['totalDays'] = totalDays;
    data['mobileNo'] = mobiileNo;
    data['referredDr'] = referredDr;
    return data;
  }
}
