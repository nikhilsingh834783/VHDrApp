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
import '../models/consultant_model.dart';


class ConsultantPayController extends GetxController {
  RxString selectedItem = '2024'.obs;
  bool apiCall = false;
  void upDateSelectedItem(String newValue) {
    selectedItem.value = newValue;
    update();
  }

  final List<String> dropdownList = ["2024", "2023"];
  final List<String> monthList = ["Feb. 2024", "Jan. 2024"];
  List<ConsultantListData> paymentStatus = [];
  final ScrollController consultantScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());

  List<DropdownMenuItem<String>> buildDropdownItems(List<String> dropdownList) {
    List<DropdownMenuItem<String>> items = [];
    for (String item in dropdownList) {
      items.add(DropdownMenuItem<String>(
        value: item,
        child: SizedBox(
          height: Sizes.crossLength * 0.05,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(item, style: commonTextStyle()),
          ),
        ),
      ));
    }
    return items;
  }

  scrollController() {
    consultantScrollController.addListener(() {
      if (consultantScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
      } else if (consultantScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });
  }

  getConsultantPay({String? selectedYear}) async {
    calenderType = 2;
    previousDateEnable = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "year": selectedYear ?? '2024'};
    apiCall = true;
    String apiUrl = getDoctorPaymentListApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token);
    debugPrint("Response ---- $finalData");
    ConsultantResponseModel filterResponse =
        ConsultantResponseModel.fromJson(finalData.data);
    if (filterResponse.statusCode == 200) {
      if (filterResponse.data != null) {
        paymentStatus = filterResponse.data!;
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
    update();
  }
}
