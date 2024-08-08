import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/main.dart';

import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../model/progress_summary_model.dart';

class ProgressSummaryController extends GetxController {
  final count = 0.obs;
  List selectedIndex = [];
  ProgressListData? progressListing;
  bool apiCall = false;
  final ScrollController progressScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());

  void increment() => count.value++;

  scrollListner() {
    progressScrollController.addListener(() {
      if (progressScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (progressScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });
  }

  getProgressSummary(
      {required String ipdNo,
      required String uhid,
      bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "ipdNo": ipdNo, "UHID": uhid};
    apiCall = true;
    String apiUrl = ConstApiUrl.getProgressSummary;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    ProgressSumaryModel patientResponse =
        ProgressSumaryModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null) {
        progressListing = patientResponse.data;
      }
      apiCall = false;
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
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
