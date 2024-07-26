import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';

import '../../../core/services/api_service.dart';
import '../../login/views/login_view.dart';
import '../model/operation_name_model.dart';
import '../model/organization_list.dart';
import '../model/save_ot_model.dart';

class OtschedulerController extends GetxController {
  final count = 0.obs;
  DateTime? selectedDate;
  String? showSelectedDateTime;

  void increment() => count.value++;

  CustomPopupMenuController selectDateController = CustomPopupMenuController();
  CustomPopupMenuController startTimePicker = CustomPopupMenuController();
  CustomPopupMenuController endTimePicker = CustomPopupMenuController();
  CustomPopupMenuController organizationNameController =
      CustomPopupMenuController();
  CustomPopupMenuController operationNamePopupController =
      CustomPopupMenuController();
  final ipdTextController = TextEditingController();
  final patientName = TextEditingController();
  final mobileController = TextEditingController();
  final surgeonNameTextController = TextEditingController();
  final schduleByController = TextEditingController();
  final uhidNumber = TextEditingController();
  final dateOfOperation = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final operationNameController = TextEditingController();
  final operationGroup = TextEditingController();
  final operationSubGroupController = TextEditingController();
  final remarksController = TextEditingController();
  final organizationContoller = TextEditingController();
  final otSchduleForKey = GlobalKey<FormState>();
  List<OperationNameList> operationNameListData = [];
  String? selectedOperation;
  String? selectedOrganization;

  int selectedHour = 10;
  int selectedMinute = 0;
  bool isAm = true;
  List<OrganizationListData> organizationListData = [];

  getOrganizationList() async {
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
    if (finalData.statusCode == 200) {
      OrganizationListModel filterResponse =
          OrganizationListModel.fromJson(finalData.data);
      if (filterResponse.data != null) {
        organizationListData = filterResponse.data!;
      }
      update();
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  createOtSchdule({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginId = prefs.getString('loginId') ?? '';
    String token = prefs.getString('token') ?? '';
    Map data = {
      "loginId": loginId,
      "ipdNo": ipdTextController.text.trim(),
      "patientName": patientName.text.trim(),
      "mobileNo": mobileController.text.trim(),
      "surgeonName": surgeonNameTextController.text.trim(),
      "scheduleBy": schduleByController.text.trim(),
      "dtOfOperation": dateOfOperation.text.trim(),
      "startTime": startTimeController.text.trim(),
      "endTime": endTimeController.text.trim(),
      "organizationName": selectedOrganization,
      "operationName": selectedOperation,
      "operationGroup": operationGroup.text.trim(),
      "operationSubGroup": operationSubGroupController.text.trim(),
      "remark": remarksController.text.trim(),
      "uhid": uhidNumber.text.trim()
    };
    String apiUrl = ConstApiUrl.saveOtSchdule;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
    SaveOtModel patientResponse = SaveOtModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      Get.rawSnackbar(message: 'OT Entry added successfully.');
      getbackFunction(context: context);
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  getbackFunction({required BuildContext context}) {
    ipdTextController.clear();
    patientName.clear();
    mobileController.clear();
    surgeonNameTextController.clear();
    schduleByController.clear();
    uhidNumber.clear();
    dateOfOperation.clear();
    startTimeController.clear();
    endTimeController.clear();
    operationNameController.clear();
    operationGroup.clear();
    operationSubGroupController.clear();
    remarksController.clear();
    organizationContoller.clear();
    // Get.back();
    Navigator.pop(context);
  }

  getOperationName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "operationNames": ""};

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
}
