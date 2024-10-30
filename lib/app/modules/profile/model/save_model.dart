class SaveModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<SaveListData>? data;

  SaveModel({
    this.statusCode,
    this.isSuccess,
    this.message,
    this.data,
  });

  factory SaveModel.fromJson(Map<String, dynamic> json) => SaveModel(
        statusCode: json["statusCode"],
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SaveListData>.from(
                json["data"]!.map((x) => SaveListData.fromJson(x))),
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

class SaveListData {
  int? savedYn;

  SaveListData({
    this.savedYn,
  });

  factory SaveListData.fromJson(Map<String, dynamic> json) => SaveListData(
        savedYn: json["savedYN"],
      );

  Map<String, dynamic> toJson() => {
        "savedYN": savedYn,
      };
}
