class RoomListModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<RoomListData>? data;

  RoomListModel({this.statusCode, this.isSuccess, this.message, this.data});

  RoomListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <RoomListData>[];
        json['data'].forEach((v) {
          data!.add(RoomListData.fromJson(v));
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

class RoomListData {
  String? serviceName;
  String? rate;

  RoomListData({this.serviceName, this.rate});

  RoomListData.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceName'] = serviceName;
    data['rate'] = rate;
    return data;
  }
}
