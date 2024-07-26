class ChargeListModel {
  int? statusCode;
  String? isSuccess;
  String? message;
  List<ChargrListData>? data;

  ChargeListModel({this.statusCode, this.isSuccess, this.message, this.data});

  ChargeListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'].runtimeType == List) {
        data = <ChargrListData>[];
        json['data'].forEach((v) {
          data!.add(ChargrListData.fromJson(v));
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

class ChargrListData {
  String? roomtype;
  String? surgeryProcCharg;
  String? surgProcHospExpTotal;
  String? surgProcHospExpEmerg;
  String? surgProcHospExpHighRsk;
  String? indoorCharges;
  String? consumables;
  String? implants;
  String? otherExp;
  String? total;

  ChargrListData(
      {this.roomtype,
      this.surgeryProcCharg,
      this.surgProcHospExpTotal,
      this.surgProcHospExpEmerg,
      this.surgProcHospExpHighRsk,
      this.indoorCharges,
      this.consumables,
      this.implants,
      this.otherExp,
      this.total});

  ChargrListData.fromJson(Map<String, dynamic> json) {
    roomtype = json['roomtype'];
    surgeryProcCharg = json['surgery_Proc_Charg'];
    surgProcHospExpTotal = json['surg_Proc_Hosp_Exp_Total'];
    surgProcHospExpEmerg = json['surg_Proc_Hosp_Exp_Emerg'];
    surgProcHospExpHighRsk = json['surg_Proc_Hosp_Exp_HighRsk'];
    indoorCharges = json['indoorCharges'];
    consumables = json['consumables'];
    implants = json['implants'];
    otherExp = json['otherExp'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomtype'] = roomtype;
    data['surgery_Proc_Charg'] = surgeryProcCharg;
    data['surg_Proc_Hosp_Exp_Total'] = surgProcHospExpTotal;
    data['surg_Proc_Hosp_Exp_Emerg'] = surgProcHospExpEmerg;
    data['surg_Proc_Hosp_Exp_HighRsk'] = surgProcHospExpHighRsk;
    data['indoorCharges'] = indoorCharges;
    data['consumables'] = consumables;
    data['implants'] = implants;
    data['otherExp'] = otherExp;
    data['total'] = total;
    return data;
  }
}
