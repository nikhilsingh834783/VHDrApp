import 'package:dio/dio.dart' as diopackage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/core/constant/const_api_url.dart';

import '../../../core/services/api_service.dart';
import '../../../core/services/biometric_service.dart';
import '../../login/model/send_otp_model.dart';
import '../../verifyotp/views/verifyotp_view.dart';

class ForgotpasswordController extends GetxController {
  final mobileController = TextEditingController();
  final generateOtpKey = GlobalKey<FormState>();

  final count = 0.obs;

  void increment() => count.value++;

  validateMobileNo() async {
    String apiUrl = ConstApiUrl.validateMobile;
    Map data = {
      "mobileNo": mobileController.text.trim(),
    };
    diopackage.Response finalData =
        await APIServices.postWithDioForlogin(apiUrl, data);
    if (finalData.statusCode == 200) {
      if (finalData.data[0]['isValid'].toString().toLowerCase() ==
          "TRUE".toLowerCase()) {
        sendOtp();
      } else {
        Get.rawSnackbar(message: finalData.data[0]["message"]);
      }
    } else if (finalData.statusCode == 400) {
      Get.rawSnackbar(message: finalData.data[0]["message"]);
    } else if (finalData.statusCode == 404) {
    } else if (finalData.statusCode == 500) {
      Get.rawSnackbar(message: "Internal server error");
    } else {
      Get.rawSnackbar(message: finalData.data[0]["message"]);
    }
  }

  sendOtp() async {
    String apiUrl = ConstApiUrl.sendOtp;
    Map data = {
      "mobileNo": mobileController.text.trim(),
    };
    diopackage.Response finalData =
        await APIServices.postWithDioForlogin(apiUrl, data);

    if (finalData.statusCode == 200) {
      SendOtpModel loginResponse = SendOtpModel.fromJson(finalData.data);
      if (loginResponse.data?.otpNo != null) {
        Get.to(() => const VerifyotpView(), arguments: {
          "otp": loginResponse.data?.otpNo,
          'mobileNo': mobileController.text.trim(),
          'from_login': false,
          'biometric': BiometricAuth.isBiomerticOn ?? false
        });
        Get.rawSnackbar(message: loginResponse.data?.otpNo);
      } else {
        Get.rawSnackbar(message: loginResponse.message);
      }
    } else if (finalData.statusCode == 400) {
      Get.rawSnackbar(message: finalData.data["message"]);
    } else if (finalData.statusCode == 404) {
    } else if (finalData.statusCode == 500) {
      Get.rawSnackbar(message: "Internal server error");
    } else {
      Get.rawSnackbar(message: finalData.data["message"]);
    }
  }
}
