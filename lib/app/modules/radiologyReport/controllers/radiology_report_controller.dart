import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../model/radio_logy_model.dart';

class RadiologyReportController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
  bool apiCall = false;
  List<RadioLogyList> allRadiologyList = [];
  final ScrollController radioScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());

  scrollListner() {
    radioScrollController.addListener(() {
      if (radioScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        bottomBarController.update();
      } else if (radioScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
      }
    });
  }

  getRadioLogyReport(
      {required String ipdNo,
      required String uhidNo,
      bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "ipdNo": ipdNo, "uhid": uhidNo};
    apiCall = true;
    String apiUrl = ConstApiUrl.getRadioLogyReports;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    RadioLogyModel patientResponse = RadioLogyModel.fromJson(finalData.data);

    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        allRadiologyList = patientResponse.data!;
      }
      apiCall = false;
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      apiCall = false;
    } else {
      apiCall = false;
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
