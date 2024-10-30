class ContactResponse {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<ContactListData>? data;

  ContactResponse({this.statusCode, this.isSuccess, this.message, this.data});

  ContactResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <ContactListData>[];
        json['data'].forEach((v) {
          data!.add(ContactListData.fromJson(v));
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

class ContactListData {
  String? name;
  String? contactNo;

  ContactListData({this.name, this.contactNo});

  ContactListData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contactNo = json['contactNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['contactNo'] = contactNo;
    return data;
  }
}
