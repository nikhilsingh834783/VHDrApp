import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';
import 'package:venus/app/modules/login/views/login_view.dart';

import '../../../../main.dart';
import '../../../core/constant/const_api_url.dart';
import '../../../core/services/api_service.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var bottomBarController = Get.put(BottomBarController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<NotificationListData> notificationListData =
      <NotificationListData>[].obs;
  RxBool apiCall = true.obs;
  final ScrollController notificationScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getNotificationList();
    notificationScrollController.addListener(() {
      if (notificationScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar.value = false;
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (notificationScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar.value = true;
        bottomBarController.update();
        // print("=====Down");
      }
    });
  }

  Future<void> getNotificationList({
    bool isLoader = true,
  }) async {
    print("===api Calling");
    // Retrieve token and loginId from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    final String loginId = prefs.getString('loginId') ?? '';

    // Prepare API request data
    final Map<String, dynamic> requestData = {
      "loginId": loginId,
    };

    // Set API URL and show loader if needed
    apiCall = true.obs;
    String apiUrl = getNotificationListApi;

    try {
      // Make API call
      final dio_package.Response response =
          await APIServices.postMethodWithHeaderDioMapData(
        body: requestData,
        apiUrl: apiUrl,
        token: token,
        isShowLoader: isLoader,
      );

      // Parse response and update the list
      final NotificationModel notificationResponse =
          NotificationModel.fromJson(response.data);
      if (notificationResponse.statusCode == 200) {
        apiCall = false.obs;
        notificationListData.assignAll(notificationResponse.data ?? []);
        update();
        // notificationListData.refresh();
      } else if (notificationResponse.statusCode == 401) {
        apiCall = false.obs;
        // Handle unauthorized error
        await _handleSessionExpiry(prefs);
      }
    } catch (e) {
      apiCall = false.obs;
      update();
      // Log or handle error
      // print("Error in getInsuranceCompany: $e");
    }
  }

  Future<void> _handleSessionExpiry(SharedPreferences prefs) async {
    await prefs.clear();
    Get.offAll(const LoginView());
    Get.rawSnackbar(
      message: 'Your session has expired. Please log in again to continue',
    );
  }
}
