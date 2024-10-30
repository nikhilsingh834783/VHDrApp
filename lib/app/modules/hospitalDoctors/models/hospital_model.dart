class HospitalDoctorResponse {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<HospitalDoctorsListData>? data;

  HospitalDoctorResponse(
      {this.statusCode, this.isSuccess, this.message, this.data});

  HospitalDoctorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <HospitalDoctorsListData>[];
        json['data'].forEach((v) {
          data!.add(HospitalDoctorsListData.fromJson(v));
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

class HospitalDoctorsListData {
  String? drImage;
  String? name;
  String? speciality;

  HospitalDoctorsListData({this.drImage, this.name, this.speciality});

  HospitalDoctorsListData.fromJson(Map<String, dynamic> json) {
    drImage = json['drImage'];
    name = json['name'];
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['drImage'] = drImage;
    data['name'] = name;
    data['speciality'] = speciality;
    return data;
  }
}
