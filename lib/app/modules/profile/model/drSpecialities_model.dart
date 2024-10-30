class DrSpecialitiesModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<DrSpecialitiesListData>? data;

  DrSpecialitiesModel({
    this.statusCode,
    this.isSuccess,
    this.message,
    this.data,
  });

  factory DrSpecialitiesModel.fromJson(Map<String, dynamic> json) =>
      DrSpecialitiesModel(
        statusCode: json["statusCode"],
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DrSpecialitiesListData>.from(
                json["data"]!.map((x) => DrSpecialitiesListData.fromJson(x))),
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

class DrSpecialitiesListData {
  String? speciality;

  DrSpecialitiesListData({
    this.speciality,
  });

  factory DrSpecialitiesListData.fromJson(Map<String, dynamic> json) =>
      DrSpecialitiesListData(
        speciality: json["speciality"],
      );

  Map<String, dynamic> toJson() => {
        "speciality": speciality,
      };
}
