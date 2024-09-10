// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/app_common_widgets/common_import.dart';
import 'package:venus/app/modules/otscheduler/views/widget/end_time_picker.dart';
import 'package:venus/app/modules/otscheduler/views/widget/start_time_picker.dart';

import '../../../core/services/api_service.dart';
import '../../costestimate/models/additional_surgeon.modal.dart';
import '../../login/views/login_view.dart';
import '../model/operation_name_model.dart';
import '../model/organization_list.dart';
import '../model/save_ot_model.dart';
import '../views/widget/additional_surgeon.dart';
import '../views/widget/custom_calendar.dart';
import '../views/widget/operation_name.dart';
import '../views/widget/organization_name_list.dart';

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
  String? docId;
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
  List<OperationNameList> selectedOperationList = [];
  String? selectedOperation;
  String? selectedOrganization;
  List<String> selectedOperationId = [];
  List<OperationNameList>? searchOperationNameListData;
  List<OrganizationListData>? searchOrganizationListData;

  int selectedHour = 10;
  int selectedMinute = 30;
  bool isAm = true;
  List<OrganizationListData> organizationListData = [];
  List<AdditionalDoctorList> additionalDoctorList = [];
  List<AdditionalDoctorList>? searchAdditionalDoctorList;

  getOrganizationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = getOrganizationListUrl;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token);
    if (finalData.statusCode == 200) {
      OrganizationListModel filterResponse =
          OrganizationListModel.fromJson(finalData.data);
      if (filterResponse.data != null) {
        organizationListData = filterResponse.data!;
        if (organizationListData.isNotEmpty) {
          organizationContoller.text =
              organizationListData[0].organization ?? '';
          selectedOrganization = organizationListData[0].orgId.toString();
        }
      }
      update();
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  Future<void> selectOperationName() async {
    showModalBottomSheet(
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: Get.context!,
      useRootNavigator: true,
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
            child: const OperationListView()),
      ),
    );
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
      "operationName": selectedOperationId,
      "operationGroup": operationGroup.text.trim(),
      "operationSubGroup": operationSubGroupController.text.trim(),
      "remark": remarksController.text.trim(),
      "uhid": uhidNumber.text.trim()
    };
    String apiUrl = saveOtSchdule;
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
    Map data = {"loginId": loginId, "operationNames": "", 'docId': docId ?? ''};

    String apiUrl = getOperationNameApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
    // print(data);
    // print(finalData);
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
    return List<Widget>.generate(
      60,
      (int index) {
        return Center(
          child: AppText(
            text: (index).toString().length < 2 ? '0$index' : '$index',
            fontSize: Sizes.px16,
            fontColor: ConstColor.black6B6B6B,
            fontWeight: FontWeight.w500,
          ),
        );
      },
    );
  }

  List<Widget> buildAmPmPicker() {
    return [
      Center(
        child: AppText(
          text: 'AM',
          fontSize: Sizes.px16,
          fontColor: ConstColor.black6B6B6B,
          fontWeight: FontWeight.w500,
        ),
      ),
      Center(
          child: AppText(
        text: 'PM',
        fontSize: Sizes.px16,
        fontColor: ConstColor.black6B6B6B,
        fontWeight: FontWeight.w500,
      )),
    ];
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

  Future<void> selectDateBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      useRootNavigator: true,
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
          child: const SelectCustomDate()),
    );
  }

  getAdditionalSurgeon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    String docId = prefs.getString('docId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = additionalSurgeonApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token);
    AdditionalSurgeonModel filterResponse =
        AdditionalSurgeonModel.fromJson(finalData.data);
    if (filterResponse.statusCode == 200) {
      if (filterResponse.data != null) {
        additionalDoctorList = filterResponse.data!;
        for (int i = 0; i < additionalDoctorList.length; i++) {
          // print(additionalDoctorList[i].docId.toString());
          if (additionalDoctorList[i].docId.toString() == docId) {
            schduleByController.text = additionalDoctorList[i].docName ?? '';
            surgeonNameTextController.text =
                additionalDoctorList[i].docName ?? '';
            docId = docId;
          }
        }
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

  Future<void> selectStartTimeBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const SelectStartTime()),
    );
  }

  searchOperationName(String text) {
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

  Future<void> selectEndTimeBottomSheet() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.50,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: const SelectEndTime()),
    );
  }

  Future<void> selectOrganizationBottomSheet() async {
    showModalBottomSheet(
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      context: Get.context!,
      useRootNavigator: true,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: Get.width,
            decoration: BoxDecoration(
                color: ConstColor.whiteColor,
                borderRadius: BorderRadius.circular(10)),
            child: const OrganizationList()),
      ),
    );
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
          child: const AdditionalSurgeonListViewOt(),
        );
      }),
    );
    update();
  }
}
