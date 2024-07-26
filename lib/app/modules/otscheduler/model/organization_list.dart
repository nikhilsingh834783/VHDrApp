class OrganizationListModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<OrganizationListData>? data;

  OrganizationListModel(
      {this.statusCode, this.isSuccess, this.message, this.data});

  OrganizationListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <OrganizationListData>[];
        json['data'].forEach((v) {
          data!.add(OrganizationListData.fromJson(v));
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

class OrganizationListData {
  int? orgId;
  String? organization;

  OrganizationListData({this.orgId, this.organization});

  OrganizationListData.fromJson(Map<String, dynamic> json) {
    orgId = json['orgId'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orgId'] = orgId;
    data['organization'] = organization;
    return data;
  }
}
