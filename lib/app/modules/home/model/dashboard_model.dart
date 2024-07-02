class DashBoardCountModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  Data? data;

  DashBoardCountModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  DashBoardCountModel.fromJson(Map<String, dynamic> json) {
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
  String? isValidToken;
  int? loginId;
  String? token;
  int? doctorId;
  String? doctorName;
  String? mobileNumber;
  String? emailAddress;
  String? doctorSpeciality;
  String? degree;
  String? degreeDisplayName;
  String? registerNo;
  String? dob;
  String? address;
  String? city;
  String? state;
  String? surgeonYN;
  String? patientCount;
  String? appointmentCount;
  String? scheduleSurgeriesCount;

  Data(
      {this.isValidToken,
      this.loginId,
      this.token,
      this.doctorId,
      this.doctorName,
      this.mobileNumber,
      this.emailAddress,
      this.doctorSpeciality,
      this.degree,
      this.degreeDisplayName,
      this.registerNo,
      this.dob,
      this.address,
      this.city,
      this.state,
      this.surgeonYN,
      this.patientCount,
      this.appointmentCount,
      this.scheduleSurgeriesCount});

  Data.fromJson(Map<String, dynamic> json) {
    isValidToken = json['is_valid_token'];
    loginId = json['login_id'];
    token = json['token'];
    doctorId = json['doctor_id'];
    doctorName = json['doctor_name'];
    mobileNumber = json['mobile_number'];
    emailAddress = json['email_address'];
    doctorSpeciality = json['doctor_speciality'];
    degree = json['degree'];
    degreeDisplayName = json['degree_display_name'];
    registerNo = json['register_no'];
    dob = json['dob'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    surgeonYN = json['surgeonYN'];
    patientCount = json['patientCount'];
    appointmentCount = json['appointmentCount'];
    scheduleSurgeriesCount = json['scheduleSurgeriesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_valid_token'] = isValidToken;
    data['login_id'] = loginId;
    data['token'] = token;
    data['doctor_id'] = doctorId;
    data['doctor_name'] = doctorName;
    data['mobile_number'] = mobileNumber;
    data['email_address'] = emailAddress;
    data['doctor_speciality'] = doctorSpeciality;
    data['degree'] = degree;
    data['degree_display_name'] = degreeDisplayName;
    data['register_no'] = registerNo;
    data['dob'] = dob;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['surgeonYN'] = surgeonYN;
    data['patientCount'] = patientCount;
    data['appointmentCount'] = appointmentCount;
    data['scheduleSurgeriesCount'] = scheduleSurgeriesCount;
    return data;
  }
}
