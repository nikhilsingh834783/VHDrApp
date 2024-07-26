import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../../opdAppointments/model/ment_model.dart';
import '../model/procedure_model.dart';

class SchduleSurgeriesController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
  DateTime selectedScheduleDate = DateTime.now();
  CustomPopupMenuController selectedDateController =
      CustomPopupMenuController();
  bool apiCall = false;
  List<ProcedureListData> procedureListData = [];
  final ScrollController schduleScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  final TextEditingController searchController = TextEditingController();
  bool showShortButton = true;

  getOpdSchdulesDates({String? searchPrefix, bool isLoader = true}) async {
    calenderType = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    calenderType = 1;
    previousDateEnable = true;
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = ConstApiUrl.getProcedureDates;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    AppointmentsDateModels patientResponse =
        AppointmentsDateModels.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        procedureDates = patientResponse.data!;
        update();
      } else {
        procedureDates = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      procedureDates = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  scrollController() {
    schduleScrollController.addListener(() {
      if (schduleScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
      } else if (schduleScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });
  }

  getSchduleListApi({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    calenderType = 1;
    apiCall = true;
    Map data = {
      "loginId": loginId,
      "selectedDate": DateFormat('dd-MMM-yyyy').format(selectedScheduleDate),
      "prefixText": searchPrefix ?? '',
    };
    String apiUrl = ConstApiUrl.schduleSurgeryListApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    ProcedureModel patientResponse = ProcedureModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      hideBottomBar.value = false;
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        procedureListData = patientResponse.data!;
        apiCall = false;
        update();
      } else {
        apiCall = false;
        procedureListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      procedureListData = [];
      apiCall = false;
      update();
    } else {
      apiCall = false;
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
