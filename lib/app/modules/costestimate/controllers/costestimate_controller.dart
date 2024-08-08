import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/costestimate/views/widgets/choose_time.dart';
import 'package:venus/app/modules/costestimate/views/widgets/consultant.dart';
import 'package:venus/app/modules/costestimate/views/widgets/organization_list.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../login/views/login_view.dart';
import '../../otscheduler/model/operation_name_model.dart';
import '../../otscheduler/model/organization_list.dart';
import '../../schedulechargelist/model/operation_class_model.dart';
import '../models/additional_surgeon.modal.dart';
import '../models/chargelist_model.dart';
import '../models/procedure_model.dart';
import '../views/widgets/additional_surgeon_list.dart';
import '../views/widgets/chhose_date.dart';
import '../views/widgets/operation_class_view.dart';
import '../views/widgets/procedure_list_view.dart';
import '../views/widgets/stay_day_list.dart';

class CostestimateController extends GetxController {
  final count = 0.obs;
  String? selectedHighRisk;
  String? selectedGender;
  List<String> highRiskList = ['Yes', "No"];
  List<String> genderList = ['Male', "Female"];

  List<String> roomList = ['Deluxe', "Suite", 'Rooms', "NICU", "Twin"];
  List<String> stayDayList = ['1', "2", '3', "4", "5"];
  int selectedTab = 0;

  final patientNameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final organizationContoller = TextEditingController();
  final consultantController = TextEditingController();
  final specialityController = TextEditingController();
  final roomTypeController = TextEditingController();
  final stayDayController = TextEditingController();
  final procedureController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final additionSurgeonController = TextEditingController();
  final highRiskController = TextEditingController();
  final consumableController = TextEditingController();
  final implantcontroller = TextEditingController();
  final otherExpenseController = TextEditingController();
  final visitChargeController = TextEditingController();
  final totalEstimateController = TextEditingController();

  final organizationPopupMenuController = CustomPopupMenuController();
  final roomPopupMenuController = CustomPopupMenuController();
  final stayDayPopupMenuController = CustomPopupMenuController();
  final additionalSurgeonController = CustomPopupMenuController();
  final procedurePopMenuController = CustomPopupMenuController();
  final selectDateController = CustomPopupMenuController();
  final genderPopupMenuController = CustomPopupMenuController();
  final highRiskPopController = CustomPopupMenuController();
  final startTimePicker = CustomPopupMenuController();
  final operationClassPopupController = CustomPopupMenuController();
  List<OperationListData> operationClassListData = [];
  List<ChargrListData> chargeListData = [];
  List<ProcedureListData> procedureListAllData = [];

  CustomPopupMenuController organizationNameController =
      CustomPopupMenuController();
  String? selectedOrganization;
  int selectedHour = 10;
  int selectedMinute = 30;
  bool isAm = true;

  void increment() => count.value++;

  List<OrganizationListData> organizationListData = [];
  List<OrganizationListData>? searchOrganizationListData;
  List<AdditionalDoctorList> additionalDoctorList = [];
  List<AdditionalDoctorList>? searchAdditionalDoctorList;
  List<OperationNameList> operationNameListData = [];
  List<OperationNameList>? searchOperationNameListData;
  List<int> selectedOperationId = [];
  List<OperationNameList> selectedOperationList = [];
  final estimateFormKey = GlobalKey<FormState>();
  String? selectedOperation;
  DateTime? selectedDate;
  String? showSelectedDateTime;
  double left = 10;
  double top = 10;
  @override
  void onInit() {
    super.onInit();
    getOrganizationList();
  }

  getOrganizationList() async {
    calenderType = 2;
    previousDateEnable = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = ConstApiUrl.getOrganizationList;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token);
    OrganizationListModel filterResponse =
        OrganizationListModel.fromJson(finalData.data);
    if (filterResponse.statusCode == 200) {
      if (filterResponse.data != null) {
        organizationListData = filterResponse.data!;
      }
    } else if (filterResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    getAdditionalSurgeon();
    getOperationName();
    getOperationClass();
  }

  getAdditionalSurgeon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = ConstApiUrl.additionalSurgeonApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token);
    AdditionalSurgeonModel filterResponse =
        AdditionalSurgeonModel.fromJson(finalData.data);
    if (filterResponse.statusCode == 200) {
      if (filterResponse.data != null) {
        additionalDoctorList = filterResponse.data!;
      }
    } else if (filterResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  getOperationName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "operationNames": "", 'docId': ''};

    String apiUrl = ConstApiUrl.getOperationNameApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
    OperationNameModel patientResponse =
        OperationNameModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        operationNameListData = patientResponse.data!;
      } else {
        operationNameListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      operationNameListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getOperationClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = ConstApiUrl.getOperationClassApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
    OperationClassModel patientResponse =
        OperationClassModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        operationClassListData = patientResponse.data!;
      } else {
        operationClassListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      operationClassListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  searchAdditionalSurgeon(String text) {
    if (text.trim().isEmpty) {
      searchAdditionalDoctorList = null;
    } else {
      searchAdditionalDoctorList = [];
      for (var userDetail in additionalDoctorList) {
        if (userDetail.docName!.toLowerCase().contains(text.toLowerCase())) {
          searchAdditionalDoctorList!.add(userDetail);
        }
      }
    }
    update();
  }

  searchOrganization(String text) {
    if (text.trim().isEmpty) {
      searchOrganizationListData = null;
    } else {
      searchOrganizationListData = [];
      for (var userDetail in organizationListData) {
        if (userDetail.organization!
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchOrganizationListData!.add(userDetail);
        }
      }
    }
    update();
  }

  List<Widget> buildHourPicker() {
    return List<Widget>.generate(12, (int index) {
      return Center(
        child: AppText(
          text: (index + 1).toString().length < 2
              ? '0${index + 1}'
              : '${index + 1}',
          fontSize: Sizes.px16,
          fontColor: ConstColor.black6B6B6B,
          fontWeight: FontWeight.w500,
        ),
      );
    });
  }

  List<Widget> buildMinutePicker() {
    return List<Widget>.generate(60, (int index) {
      return Center(
        child: AppText(
          text: (index).toString().length < 2 ? '0$index' : '$index',
          fontSize: Sizes.px16,
          fontColor: ConstColor.black6B6B6B,
          fontWeight: FontWeight.w500,
        ),
      );
    });
  }

  List<Widget> buildAmPmPicker() {
    return [
      Center(
          child: AppText(
        text: 'AM',
        fontSize: Sizes.px16,
        fontColor: ConstColor.black6B6B6B,
        fontWeight: FontWeight.w500,
      )),
      Center(
          child: AppText(
        text: 'PM',
        fontSize: Sizes.px16,
        fontColor: ConstColor.black6B6B6B,
        fontWeight: FontWeight.w500,
      )),
    ];
  }

  getChargeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "patientName": patientNameController.text.trim(),
      "age": ageController.text.trim(),
      "gender": genderController.text.trim(),
      "orgName": organizationContoller.text.trim(),
      "consultant": consultantController.text.trim(), //649
      "speciality": specialityController.text.trim(),
      "roomType": roomTypeController.text.trim(),
      "stayDays": stayDayController.text.trim(),
      "procedureNm": selectedOperationId,
      "dateOfSurgery": dateController.text.trim(),
      "timeOfSurgery": timeController.text.trim(),
      "additionalSurgeon": additionSurgeonController.text.trim(),
      "highRiskType": highRiskController.text.trim(),
      "consumables": consumableController.text.trim(),
      "implants": implantcontroller.text.trim(),
      "otherExpense": otherExpenseController.text.trim(),
      "consultantVisitCharge": visitChargeController.text.trim(),
      "totalEstimate": totalEstimateController.text.trim()
    };
    String apiUrl = ConstApiUrl.getSurgicalEstimateapi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
    ChargeListModel patientResponse = ChargeListModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        chargeListData = patientResponse.data!;
      } else {
        chargeListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      chargeListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getProcedureList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "patientName": patientNameController.text.trim(),
      "age": ageController.text.trim(),
      "gender": genderController.text.trim(),
      "orgName": organizationContoller.text.trim(),
      "consultant": consultantController.text.trim(), //649
      "speciality": specialityController.text.trim(),
      "roomType": roomTypeController.text.trim(),
      "stayDays": stayDayController.text.trim(),
      "procedureNm": selectedOperationId,
      "dateOfSurgery": dateController.text.trim(),
      "timeOfSurgery": timeController.text.trim(),
      "additionalSurgeon": additionSurgeonController.text.trim(),
      "highRiskType": highRiskController.text.trim(),
      "consumables": consumableController.text.trim(),
      "implants": implantcontroller.text.trim(),
      "otherExpense": otherExpenseController.text.trim(),
      "consultantVisitCharge": visitChargeController.text.trim(),
      "totalEstimate": totalEstimateController.text.trim()
    };
    String apiUrl = ConstApiUrl.getSurgicalEstimateapiProcedure;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
    ProcedureModel patientResponse = ProcedureModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        procedureListAllData = patientResponse.data!;
      } else {
        procedureListAllData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      procedureListAllData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  Future<void> showAdditionalSurgeon({required BuildContext context}) async {
    await showModalBottomSheet(
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: context,
      useRootNavigator: true,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const AdditionalSurgeonListView(),
        );
      }),
    );
    update();
  }

  Future<void> selectOrganizationBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const OrganizationList()),
      ),
    );
  }

  Future<void> selectDateBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const ChooseDateView()),
    );
  }

  Future<void> selectTimeBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.55,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const ChooseTimeView()),
    );
  }

  Future<void> selectOperationName() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const ProcedureListViewOperation()),
      ),
    );
  }

  Future<void> selectRoomBottom() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const SelectOperationClassView()),
      ),
    );
  }

  Future<void> selectDaysBottom() async {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const StayDayList()),
      ),
    );
  }

  Future<void> selectSurgeonBottom({required BuildContext context}) async {
    await showModalBottomSheet(
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: context,
      useRootNavigator: true,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const ConsultantSurgeonListView(),
        );
      }),
    );
    update();
  }

  searchOpearationName(String text) {
    if (text.trim().isEmpty) {
      searchOperationNameListData = null;
    } else {
      searchOperationNameListData = [];
      for (var userDetail in operationNameListData) {
        if (userDetail.operationName!
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchOperationNameListData!.add(userDetail);
        }
      }
    }
    update();
  }
}
