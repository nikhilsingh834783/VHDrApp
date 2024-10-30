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
import '../models/hospital_model.dart';

class HospitalDoctorsController extends GetxController {
  bool apiCall = false;
  final ScrollController doctorsScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  List<HospitalDoctorsListData> hospitalListData = [];
  final searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    doctorsScrollController.addListener(() {
      if (doctorsScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        bottomBarController.update();
      } else if (doctorsScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
      }
    });
  }

  getHospitalDoctors({String? searchPrefix, bool isLoader = true}) async {
    calenderType = 2;
    previousDateEnable = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "searchText": searchPrefix ?? ''};
    apiCall = true;
    String apiUrl = getHospitalDoctorsApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    HospitalDoctorResponse filterResponse =
        HospitalDoctorResponse.fromJson(finalData.data);
    if (filterResponse.statusCode == 200) {
      if (filterResponse.data != null) {
        hospitalListData = filterResponse.data!;
      } else {
        hospitalListData = [];
      }
    } else if (filterResponse.statusCode == 400) {
      hospitalListData = [];
    } else if (filterResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
