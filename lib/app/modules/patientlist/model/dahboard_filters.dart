class DashBoardFiltersModels {
  int? statusCode;
  String? isSuccess;
  String? message;
  Data? data;

  DashBoardFiltersModels(
      {this.statusCode, this.isSuccess, this.message, this.data});

  DashBoardFiltersModels.fromJson(Map<String, dynamic> json) {
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
  List<Orgs>? orgs;
  List<Floors>? floors;
  List<Wards>? wards;

  Data({this.orgs, this.floors, this.wards});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orgs'] != null) {
      orgs = <Orgs>[];
      json['orgs'].forEach((v) {
        orgs!.add(Orgs.fromJson(v));
      });
    }
    if (json['floors'] != null) {
      floors = <Floors>[];
      json['floors'].forEach((v) {
        floors!.add(Floors.fromJson(v));
      });
    }
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards!.add(Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orgs != null) {
      data['orgs'] = orgs!.map((v) => v.toJson()).toList();
    }
    if (floors != null) {
      data['floors'] = floors!.map((v) => v.toJson()).toList();
    }
    if (wards != null) {
      data['wards'] = wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orgs {
  String? isValidToken;
  String? organization;

  Orgs({this.isValidToken, this.organization});

  Orgs.fromJson(Map<String, dynamic> json) {
    isValidToken = json['isValidToken'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValidToken'] = isValidToken;
    data['organization'] = organization;
    return data;
  }
}

class Floors {
  String? isValidToken;
  int? floorId;
  String? floorName;

  Floors({this.isValidToken, this.floorId, this.floorName});

  Floors.fromJson(Map<String, dynamic> json) {
    isValidToken = json['isValidToken'];
    floorId = json['floorId'];
    floorName = json['floorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValidToken'] = isValidToken;
    data['floorId'] = floorId;
    data['floorName'] = floorName;
    return data;
  }
}

class Wards {
  String? isValidToken;
  int? wardId;
  String? wardName;

  Wards({this.isValidToken, this.wardId, this.wardName});

  Wards.fromJson(Map<String, dynamic> json) {
    isValidToken = json['isValidToken'];
    wardId = json['wardId'];
    wardName = json['wardName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isValidToken'] = isValidToken;
    data['wardId'] = wardId;
    data['wardName'] = wardName;
    return data;
  }
}
