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

class ProcedureListData {
  String? patientName;
  String? mobileNo;
  String? schTime;
  String? assisSurgnNm;
  String? surgeryName;
  String? uhid;
  String? ipdNo;
  String? startTime;
  String? endTime;
  String? operationDate;
  String? operationIds;
  String? drId;
  String? speciality;

  ProcedureListData(
      {this.patientName,
      this.mobileNo,
      this.schTime,
      this.assisSurgnNm,
      this.surgeryName,
      this.uhid,
      this.ipdNo,
      this.startTime,
      this.endTime,
      this.operationDate,
      this.operationIds,
      this.drId,
      this.speciality});

  ProcedureListData.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    mobileNo = json['mobileNo'];
    schTime = json['schTime'];
    assisSurgnNm = json['assisSurgnNm'];
    surgeryName = json['surgeryName'];
    uhid = json['uhid'];
    ipdNo = json['ipdNo'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    operationDate = json['operationDate'];
    operationIds = json['operationIds'];
    drId = json['drId'];
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientName'] = patientName;
    data['mobileNo'] = mobileNo;
    data['schTime'] = schTime;
    data['assisSurgnNm'] = assisSurgnNm;
    data['surgeryName'] = surgeryName;
    data['uhid'] = uhid;
    data['ipdNo'] = ipdNo;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['operationDate'] = operationDate;
    data['operationIds'] = operationIds;
    data['drId'] = drId;
    data['speciality'] = speciality;
    return data;
  }
}
