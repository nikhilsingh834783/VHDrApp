class NotificationModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<NotificationListData>? data;

  NotificationModel({this.statusCode, this.isSuccess, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationListData>[];
      json['data'].forEach((v) {
        data!.add(NotificationListData.fromJson(v));
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

class NotificationListData {
  int? id;
  String? messageTitle;
  String? message;
  String? status;
  String? sentDate;

  NotificationListData(
      {this.id, this.messageTitle, this.message, this.status, this.sentDate});

  NotificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageTitle = json['messageTitle'];
    message = json['message'];
    status = json['status'];
    sentDate = json['sentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['messageTitle'] = messageTitle;
    data['message'] = message;
    data['status'] = status;
    data['sentDate'] = sentDate;
    return data;
  }
}
