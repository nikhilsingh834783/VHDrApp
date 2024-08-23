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
import '../model/appoint_ment_model.dart';
import '../model/ment_model.dart';

class OpdAppointmentsController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
  DateTime selectedDate = DateTime.now();
  CustomPopupMenuController selectDateController = CustomPopupMenuController();
  List<AppointMentListData> appointmentData = [];
  final ScrollController appointmentScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  String showDateTime = '';
  bool apiCall = false;
  final searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  getOpdAppointmentsDates({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    calenderType = 0;
    previousDateEnable = true;
    Map data = {
      "loginId": loginId,
    };

    String apiUrl = getApdAppointmentsDatesUrl;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    AppointmentsDateModels patientResponse =
        AppointmentsDateModels.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        appointMentsDate = patientResponse.data!;
        update();
      } else {
        appointMentsDate = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      appointMentsDate = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  scrollController() {
    appointmentScrollController.addListener(() {
      if (appointmentScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
      } else if (appointmentScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });
  }

  getOpdAppointments({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    calenderType = 0;
    apiCall = true;
    Map data = {
      "loginId": loginId,
      "selectedDate": DateFormat('dd-MMM-yyyy').format(selectedDate),
      "prefixText": searchPrefix ?? '',
    };
    String apiUrl = getApdAppointmentsUrl;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    AppointmentsModels patientResponse =
        AppointmentsModels.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        appointmentData = patientResponse.data!;
        apiCall = false;
        update();
      } else {
        apiCall = false;
        appointmentData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      appointmentData = [];
      apiCall = false;
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
