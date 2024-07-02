import 'package:dio/dio.dart' as diopackage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/core/constant/const_api_url.dart';
import 'package:venus/app/core/services/api_service.dart';
import 'package:venus/app/modules/login/model/login_model.dart';
import 'package:venus/app/modules/login/views/login_view.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final resetPasswordKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final count = 0.obs;
  var getData = Get.arguments;
  String mobileNo = '';
  String otp = '';
  @override
  void onInit() {
    super.onInit();
    if (getData != null) {
      mobileNo = getData['mobileNo'];
      otp = getData['otp'];
    }
  }

  resetPassworApi() async {
    String apiUrl = ConstApiUrl.newPassword;
    Map data = {
      "mobileNo": mobileNo,
      "password": newPasswordController.text.trim()
    };

    diopackage.Response finalData =
        await APIServices.postWithDioForlogin(apiUrl, data);

    if (finalData.statusCode == 200) {
      LoginModel passwordResponse = LoginModel.fromJson(finalData.data);
      if (passwordResponse.isSuccess.toString().toLowerCase() ==
          "TRUE".toLowerCase()) {
        Get.offAll(const LoginView());
        Get.rawSnackbar(message: passwordResponse.message);
      } else {
        Get.rawSnackbar(message: passwordResponse.message);
      }
    } else if (finalData.statusCode == 400) {
      Get.rawSnackbar(message: finalData.data["message"]);
    } else if (finalData.statusCode == 500) {
      Get.rawSnackbar(message: "Internal server error");
    } else {
      Get.rawSnackbar(message: finalData.data["message"]);
    }
  }

  void increment() => count.value++;
}
