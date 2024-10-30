import 'dart:convert';

import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/insuranceCompanies/models/corporate_model.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../models/cashless_model.dart';

class InsuranceCompaniesController extends GetxController {
  bool apiCall = false;
  int selectedTab = 0;
  final searchController = TextEditingController();
  final ScrollController cashlessScrollController = ScrollController();
  final ScrollController corporateScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  bool showShortButton = true;
  List<CashlessListData> cashLessList = [];
  List<CorporateListData> corporateList = [];

  @override
  void onInit() {
    super.onInit();
    cashlessScrollController.addListener(() {
      if (cashlessScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        bottomBarController.update();
        // update(0.0, true);
      } else if (cashlessScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
      }
    });

    corporateScrollController.addListener(() {
      if (corporateScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        bottomBarController.update();
      } else if (corporateScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
      }
    });
  }

  getInsuranceCompany(
      {String? selectedTab, String? prefixText, bool isloader = true}) async {
    calenderType = 2;
    previousDateEnable = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "flag": selectedTab,
      "searchText": prefixText
    };
    print(jsonEncode(data));
    apiCall = true;
    String apiUrl = getInsuranceCompanies;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isloader);
    cashLessList = [];
    corporateList = [];
    if (selectedTab == 'Cashless') {
      CashlessResponse filterResponse =
          CashlessResponse.fromJson(finalData.data);
      print(finalData.data);
      if (filterResponse.statusCode == 200) {
        if (filterResponse.data != null) {
          cashLessList = filterResponse.data!;
        }
      } else if (filterResponse.statusCode == 401) {
        prefs.clear();
        Get.offAll(const LoginView());
        // Get.rawSnackbar(message: finalData.data['message']);
        Get.rawSnackbar(
            message:
                'Your session has expired. Please log in again to continue');
      }
    } else {
      CorporateResponse filterResponse =
          CorporateResponse.fromJson(finalData.data);
      print(finalData.data);
      if (filterResponse.statusCode == 200) {
        if (filterResponse.data != null) {
          corporateList = filterResponse.data!;
        }
      } else if (filterResponse.statusCode == 401) {
        prefs.clear();
        Get.offAll(const LoginView());
        // Get.rawSnackbar(message: finalData.data['message']);
        Get.rawSnackbar(
            message:
                'Your session has expired. Please log in again to continue');
      }
    }
    update();
  }
}
