class DrDegreeModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<DrDegreeListData>? data;

  DrDegreeModel({
    this.statusCode,
    this.isSuccess,
    this.message,
    this.data,
  });

  factory DrDegreeModel.fromJson(Map<String, dynamic> json) => DrDegreeModel(
        statusCode: json["statusCode"],
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DrDegreeListData>.from(
                json["data"]!.map((x) => DrDegreeListData.fromJson(x))),
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

class DrDegreeListData {
  String? degree;

  DrDegreeListData({
    this.degree,
  });

  factory DrDegreeListData.fromJson(Map<String, dynamic> json) =>
      DrDegreeListData(
        degree: json["degree"],
      );

  Map<String, dynamic> toJson() => {
        "degree": degree,
      };
}
