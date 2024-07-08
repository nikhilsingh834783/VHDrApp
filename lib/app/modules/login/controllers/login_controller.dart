// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:dio/dio.dart' as diopackage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/app_common_widgets/common_elevated_button.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/const_api_url.dart';
import 'package:venus/app/core/services/api_service.dart';
import 'package:venus/app/core/services/biometric_service.dart';
import 'package:venus/app/core/services/local_pref.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/bottomBar/views/bottom_bar_view.dart';
import 'package:venus/app/modules/login/model/login_model.dart';

import '../../../app_common_widgets/custom_pop_menu.dart';
import '../../verifyotp/views/verifyotp_view.dart';
import '../model/send_otp_model.dart';

class LoginController extends GetxController {
  bool withPaasword = false;
  bool hidePassword = true;
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool biometricEnable = false;
  final organizationPopupMenuController = CustomPopupMenuController();
  DateTime? selectedDate;
  String? showSelectedDateTime;

  @override
  void onInit() async {
    super.onInit();
    // getPatientList();
    await BiometricAuth.checkBiometric();
    update();
  }

  validateMobileNo(BuildContext context) async {
    String apiUrl = ConstApiUrl.validateMobile;
    Map data = {
      "mobileNo": mobileController.text.trim(),
    };
    diopackage.Response finalData =
        await APIServices.postWithDioForlogin(apiUrl, data);
    if (finalData.statusCode == 200) {
      if (finalData.data[0]['isValid'].toString().toLowerCase() ==
          "TRUE".toLowerCase()) {
        if (withPaasword) {
          loginApiCall(context);
        } else {
          // Get.to(const VerifyotpView());
          sendOtp(context);
        }
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

  void biometricOnChanged(bool v) async {
    await BiometricAuth.checkBiometric();
    if (v) {
      // print(BiometricAuth.is);
      if (BiometricAuth.isBiometricAvailable || BiometricAuth.isFaceAvailable) {
        await BiometricAuth.authenticate(value: v, fromLogin: true);
        update();
      } else {
        onBimetricSetupDialog();
      }
    } else {
      BiometricAuth.onBiometricSwitch(v);
      update();
    }
  }

  Future<void> onBimetricSetupDialog() {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return SizedBox(
            width: Get.size.width * 0.45,
            child: AlertDialog(
              // isTitleAlign: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Alert",
                    textAlign: TextAlign.center,
                    fontColor: ConstColor.buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.px18, // 18.spMin,
                  ),
                ],
              ),
              content: AppText(
                text:
                    "Biometric is not set up. would you like to set it up for biometric login?",
                fontSize: Sizes.px14, // 14.sp,
                textAlign: TextAlign.center,
                fontColor: ConstColor.blackTextColor,
                fontWeight: FontWeight.w300,
              ),
              actions: [
                SizedBox(
                  height: getDynamicHeight(size: 0.050),
                  child: AppButton(
                      radius: 50,
                      text: "Biometric Setup",
                      onPressed: () {
                        BiometricAuth.goToBiometricSettings().whenComplete(() {
                          Get.back();
                        });
                        // unLockBtn();
                      }),
                ),
              ],
            ),
          );
        });
  }

  sendOtp(BuildContext context) async {
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
          'from_login': true,
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

  loginApiCall(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;
    IosDeviceInfo? iosInfo;
    final deviceNames = DeviceMarketingNames();
    String? singleDeviceName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiUrl = ConstApiUrl.loginWithPassword;
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else {
      singleDeviceName = await deviceNames.getSingleName();
      iosInfo = await deviceInfo.iosInfo;
    }
    Map data = {
      "mobileNo": mobileController.text.trim(),
      "password": passwordController.text.trim(),
      "deviceType": Platform.isAndroid ? '1' : '2',
      "otp": "",
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
    if (finalData.statusCode == 200) {
      LoginModel loginResponse = LoginModel.fromJson(finalData.data);
      if (loginResponse.isSuccess.toString().toLowerCase() ==
          "true".toLowerCase()) {
        LocalPref.saveDataPref('token', loginResponse.data?.token ?? '');
        prefs.setString(
            'loginId', loginResponse.data?.loginId.toString() ?? '');
        prefs.setString('token', loginResponse.data?.token ?? '');
        prefs.setString('username', loginResponse.data?.doctorName ?? '');
        prefs.setBool('biometric', BiometricAuth.isBiomerticOn ?? false);
        Get.offAll(const BottomBarView());
      } else {
        Get.rawSnackbar(message: finalData.data["message"]);
      }
    } else if (finalData.statusCode == 400) {
      Get.rawSnackbar(message: finalData.data["message"]);
    } else if (finalData.statusCode == 404) {
      Get.rawSnackbar(message: "User not found.");
    } else if (finalData.statusCode == 500) {
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(message: "Internal server error");
      }
    } else {
      Get.rawSnackbar(message: finalData.data["message"]);
    }
  }
}
