import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:dio/dio.dart' as diopackage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/core/constant/const_api_url.dart';
import 'package:venus/app/core/services/api_service.dart';
import 'package:venus/app/core/services/biometric_service.dart';
import 'package:venus/app/core/services/local_pref.dart';
import 'package:venus/app/modules/bottomBar/views/bottom_bar_view.dart';
import 'package:venus/app/modules/login/model/login_model.dart';
import 'package:venus/app/modules/resetPassword/views/reset_password_view.dart';

import '../../login/model/send_otp_model.dart';

class VerifyotpController extends GetxController {
  RxInt secondsRemaining = 150.obs;
  Timer? timer;
  RxBool enableResendOtp = false.obs;
  final otpController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  var getData = Get.arguments;
  String mobileNo = '';
  String otp = '';
  bool fromLogin = false;
  bool biometric = false;
  @override
  void onInit() {
    super.onInit();
    timerRemain();
    if (getData != null) {
      mobileNo = getData['mobileNo'];
      otp = getData['otp'];
      fromLogin = getData['from_login'];
      if (getData['biometric'] != null) {
        biometric = getData['biometric'];
      }
    }
  }

  timerRemain() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0.obs) {
        secondsRemaining.value--;
      } else {
        enableResendOtp.value = true;
        timer?.cancel();
      }
    });
  }

  saveToken() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;
    final deviceNames = DeviceMarketingNames();
    String? singleDeviceName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = loginWithPassword;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else {
      singleDeviceName = await deviceNames.getSingleName();
      iosInfo = await deviceInfo.iosInfo;
    }
    Map data = {
      "mobileNo": mobileNo,
      "password": '',
      "deviceType": Platform.isAndroid ? '1' : '2',
      "otp": otpController.text.trim(),
      "deviceName": Platform.isAndroid
          ? androidInfo!.model.toString()
          : singleDeviceName.toString(),
      "osType": Platform.isAndroid
          ? androidInfo?.version.release.toString()
          : iosInfo!.systemVersion.toString(),
      "deviceToken": "string"
    };
    diopackage.Response finalData =
        await APIServices.postWithDioForlogin(apiUrl, data);
    // s
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // timer?.cancel();
    // secondsRemaining = 150.obs;
    // enableResendOtp.value = false;
    // await timerRemain();
    // String apiUrl = ConstApiUrl.diplayDashBoard;
    // Map data = {
    //   "mobileNo": mobileNo,
    //   "tokenNo": "",
    //   "deviceType": Platform.isAndroid ? "1" : '2'
    // };

    if (finalData.statusCode == 200) {
      LoginModel loginResponse = LoginModel.fromJson(finalData.data);
      if (loginResponse.isSuccess.toString().toLowerCase() ==
          "true".toLowerCase()) {
        LocalPref.saveDataPref('token', loginResponse.data?.token ?? '');
        prefs.setString('token', loginResponse.data?.token ?? '');
        prefs.setString(
            'loginId', loginResponse.data?.loginId.toString() ?? '');
        prefs.setString('docId', loginResponse.data?.doctorId.toString() ?? '');
        prefs.setString('username', loginResponse.data?.doctorName ?? '');
        prefs.setBool('biometric', BiometricAuth.isBiomerticOn ?? false);

        Get.offAll(const BottomBarView());
      } else {
        Get.rawSnackbar(message: finalData.data["message"]);
      }
    } else if (finalData.statusCode == 400) {
      Get.rawSnackbar(message: finalData.data["message"]);
    } else if (finalData.statusCode == 500) {
      Get.rawSnackbar(message: "Internal server error");
    } else {
      Get.rawSnackbar(message: finalData.data["message"]);
    }
  }

  resendApiCall(BuildContext context) async {
    String apiUrl = sendOtpUrl;
    Map data = {
      "mobileNo": mobileNo,
    };
    diopackage.Response finalData =
        await APIServices.postWithDioForlogin(apiUrl, data);
    if (finalData.statusCode == 200) {
      timer?.cancel();
      secondsRemaining = 150.obs;
      enableResendOtp.value = false;
      await timerRemain();
      SendOtpModel loginResponse = SendOtpModel.fromJson(finalData.data);

      if (loginResponse.data?.otpNo != null) {
        otp = loginResponse.data!.otpNo!;
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

  verifyOtp() {
    if (otp == otpController.text.trim()) {
      if (fromLogin) {
        saveToken();
      } else {
        timer?.cancel();
        secondsRemaining = 150.obs;
        enableResendOtp.value = true;
        Get.to(() => const ResetPasswordView(),
            duration: const Duration(milliseconds: 700),
            arguments: {"otp": otp, 'mobileNo': mobileNo});
      }
    } else {
      Get.rawSnackbar(message: "Otp didn't match");
    }
  }
}
