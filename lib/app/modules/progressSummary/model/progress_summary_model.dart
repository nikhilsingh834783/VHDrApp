class ProgressSumaryModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  ProgressListData? data;

  ProgressSumaryModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  ProgressSumaryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    data =
        json['data'] != null ? ProgressListData.fromJson(json['data']) : null;
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

class ProgressListData {
  String? isValidToken;
  String? patientName;
  String? beds;
  String? diagnosis;
  String? clinicalSummary;
  String? medicalHistory;
  String? treatmentGiven;

  ProgressListData(
      {this.isValidToken,
      this.patientName,
      this.beds,
      this.diagnosis,
      this.clinicalSummary,
      this.medicalHistory,
      this.treatmentGiven});

  ProgressListData.fromJson(Map<String, dynamic> json) {
    isValidToken = json['isValidToken'];
    patientName = json['patientName'];
    beds = json['beds'];
    diagnosis = json['diagnosis'];
    clinicalSummary = json['clinicalSummary'];
    medicalHistory = json['medicalHistory'];
    treatmentGiven = json['treatmentGiven'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValidToken'] = isValidToken;
    data['patientName'] = patientName;
    data['beds'] = beds;
    data['diagnosis'] = diagnosis;
    data['clinicalSummary'] = clinicalSummary;
    data['medicalHistory'] = medicalHistory;
    data['treatmentGiven'] = treatmentGiven;
    return data;
  }
}
