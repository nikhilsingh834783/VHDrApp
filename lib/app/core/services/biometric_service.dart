import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';
import 'package:venus/app/core/services/appPreference.dart';
import 'package:venus/app/core/services/local_pref.dart';

class BiometricAuth {
  static bool? isBiomerticOn = false;
  // static bool isBiometricConfig = false;
  static LocalAuthentication localAuthentication = LocalAuthentication();
  static bool isBiometricAvailable = false;
  static bool isFaceAvailable = false;
  static bool isDeviceSupported = false;

  static void onBiometricSwitch(bool value) async {
    isBiomerticOn = value;
    // LocalPref.saveDataPref(
    //     AppPreferencesHelper.isBiometricEnable, value.toString());
  }

  static void getBiometric() {
    if (isFaceAvailable || isBiometricAvailable) {
      isBiomerticOn =
          LocalPref.getPrefData(AppPreferencesHelper.isBiometricEnable);
    } else {
      isBiomerticOn = false;
      LocalPref.saveDataPref(
          AppPreferencesHelper.isBiometricEnable, isBiomerticOn.toString());
    }
    print("getBiometric $isBiomerticOn");
  }

  static Future<void> authenticate(
      {required bool value, bool fromLogin = false}) async {
    bool authenticated = false;
    try {
      authenticated = await localAuthentication.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
      if (authenticated) {
        if (!fromLogin) {
          Get.rawSnackbar(message: "Authentication Successully");
        }
        isBiomerticOn = value;
        LocalPref.saveDataPref(
            AppPreferencesHelper.isBiometricEnable, value.toString());
        // Utils.getStorage.remove('userData');
        // Get.offAllNamed(Routes.LANDING);
      } else {
        Get.rawSnackbar(message: "Authentication failed.");
      }
    } catch (e) {
      Get.log('Error during biometric authentication: $e');
    }

    if (authenticated) {
      Get.log('Biometric authentication successful');
    } else {
      Get.log('Biometric authentication failed');
    }
  }

  static Future<void> checkBiometric() async {
    BiometricAuth.isDeviceSupported =
        await localAuthentication.canCheckBiometrics;
    var isAvailable = await localAuthentication.getAvailableBiometrics();
    // setState(() {
    isFaceAvailable = isAvailable
        .where((element) => (element == BiometricType.face ||
            (element == BiometricType.strong || element == BiometricType.weak)))
        .isNotEmpty;
    isBiometricAvailable = isAvailable
        .where((element) => (element == BiometricType.fingerprint ||
            (element == BiometricType.strong || element == BiometricType.weak)))
        .isNotEmpty;

    for (var element in isAvailable) {
      log("Bio Type: ${element.name}");
    }
    // BiometricAuth.getBiometric();
    // update();
  }

  static Future<bool> goToBiometricSettings() async {
    const settingsiOS = OpenSettingsPlusIOS();
    const settingsAndroid = OpenSettingsPlusAndroid();
    if (Platform.isIOS) {
      var data = await settingsiOS.faceIDAndPasscode();
      Get.log("FaceId $data");
      return data;
    } else if (Platform.isAndroid) {
      var data = await settingsAndroid.biometricEnroll();
      Get.log("Biometric $data");
      return data;
    } else {
      return false;
    }
  }
}
