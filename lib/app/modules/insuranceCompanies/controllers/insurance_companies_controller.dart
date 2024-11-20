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
  bool corporateApiCall = false;
  bool cashlessApiCall = false;

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

  Future<void> getInsuranceCompany({
    String? selectedTab,
    String? prefixText,
    bool isLoader = true,
  }) async {
    // Initialize necessary variables
    calenderType = 2;
    previousDateEnable = false;

    // Retrieve token and loginId from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    final String loginId = prefs.getString('loginId') ?? '';

    // Prepare API request data
    final Map<String, dynamic> requestData = {
      "loginId": loginId,
      "flag": selectedTab,
      "searchText": prefixText,
    };

    // Set API URL and show loader if needed
    apiCall = true;
    String apiUrl = getInsuranceCompanies;

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
      final CashlessResponse filterResponse =
          CashlessResponse.fromJson(response.data);
      if (filterResponse.statusCode == 200) {
        cashLessList = filterResponse.data ?? [];
      } else if (filterResponse.statusCode == 401) {
        // Handle unauthorized error
        await _handleSessionExpiry(prefs);
      }
    } catch (e) {
      // Log or handle error
      // print("Error in getInsuranceCompany: $e");
    } finally {
      update();
    }
  }

  Future<void> _handleSessionExpiry(SharedPreferences prefs) async {
    await prefs.clear();
    Get.offAll(const LoginView());
    Get.rawSnackbar(
      message: 'Your session has expired. Please log in again to continue',
    );
  }

  Future<void> getCorporateInsuranceCompany({
    String? selectedTab,
    String? prefixText,
    bool isLoader = true,
  }) async {
    // Initialize necessary variables
    calenderType = 2;
    previousDateEnable = false;

    // Retrieve token and loginId from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    final String loginId = prefs.getString('loginId') ?? '';

    // Prepare API request data
    final Map<String, dynamic> requestData = {
      "loginId": loginId,
      "flag": selectedTab,
      "searchText": prefixText,
    };

    // Set API URL and enable loader if needed
    apiCall = true;
    String apiUrl = getInsuranceCompanies;

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
      final CorporateResponse filterResponse =
          CorporateResponse.fromJson(response.data);
      if (filterResponse.statusCode == 200) {
        corporateList = filterResponse.data ?? [];
      } else if (filterResponse.statusCode == 401) {
        // Handle unauthorized error
        await _handleSessionExpiry(prefs);
      }
    } catch (e) {
      // Log or handle error
      print("Error in getCorporateInsuranceCompany: $e");
    } finally {
      update();
    }
  }
}
