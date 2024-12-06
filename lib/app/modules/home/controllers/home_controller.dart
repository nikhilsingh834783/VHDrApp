import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/core/constant/const_api_url.dart';
import 'package:venus/app/core/services/api_service.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:venus/app/modules/home/model/dashboard_model.dart';
import 'package:venus/app/modules/profile/controllers/profile_controller.dart';

import '../../../../main.dart';
import '../../login/views/login_view.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  DashBoardCountModel? dataForDashBoard;
  var profileController = Get.put(ProfileController());
  // List<DashBoardCountModel> dashboardList = [];

  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();
    getDashboardData();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar.value = false;
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar.value = true;
        bottomBarController.update();
        // print("=====Down");
      }
    });
    profileController.getDrDegree();
    profileController.getDrSpeciality();
    profileController.getProfileClass();
    profileController.getProfileImage();
  }

  getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId};
    String apiUrl = diplayDashBoard;
    debugPrint(apiUrl);
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: true);
    if (finalData.statusCode == 200) {
      dataForDashBoard = DashBoardCountModel.fromJson(finalData.data);
      if (dataForDashBoard!.statusCode == 200) {
        update();
      } else if (dataForDashBoard!.statusCode == 401) {
        prefs.clear();
        Get.offAll(const LoginView());
        Get.rawSnackbar(
            message:
                'Your session has expired. Please log in again to continue');
      } else {
        Get.rawSnackbar(message: "Something went wrong");
      }
    }
  }
}
// Your session has expired due to inactivity. Please log in again to continue.
