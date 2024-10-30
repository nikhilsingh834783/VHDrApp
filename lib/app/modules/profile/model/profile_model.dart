class ProfileModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<ProfileListData>? data;

  ProfileModel({
    this.statusCode,
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        statusCode: json["statusCode"],
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProfileListData>.from(
                json["data"]!.map((x) => ProfileListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "isSuccess": isSuccess,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProfileListData {
  String? loginId;
  String? name;
  String? mobile;
  String? email;
  String? speciality;
  String? degree;
  String? regNo;
  String? dob;
  String? address;
  String? city;
  String? state;

  ProfileListData({
    this.loginId,
    this.name,
    this.mobile,
    this.email,
    this.speciality,
    this.degree,
    this.regNo,
    this.dob,
    this.address,
    this.city,
    this.state,
  });

  factory ProfileListData.fromJson(Map<String, dynamic> json) =>
      ProfileListData(
        loginId: json["loginId"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        speciality: json["speciality"],
        degree: json["degree"],
        regNo: json["regNo"],
        dob: json["dob"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "loginId": loginId,
        "name": name,
        "mobile": mobile,
        "email": email,
        "speciality": speciality,
        "degree": degree,
        "regNo": regNo,
        "dob": dob,
        "address": address,
        "city": city,
        "state": state,
      };
}
