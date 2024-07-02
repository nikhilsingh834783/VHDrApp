import 'dart:io';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:open_settings_plus/core/open_settings_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/bottomBar/views/bottom_bar_view.dart';

class BiometricauthController extends GetxController {
  LocalAuthentication localAuthentication = LocalAuthentication();
  bool isBiometricAvailable = false;
  bool isFaceAvailable = false;
  // GetConfigResponse globalConfig = GetConfigResponse();
  bool isAuthenticating = false;
  String userName = '';
  @override
  void onInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('username') ?? '-';
    await checkBiometric();
    update();
    super.onInit();
  }

  @override
  void onReady() async {
    if (isFaceAvailable || isFaceAvailable) {
      await onAuthenticate();
    }
    super.onReady();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   // if (Platform.isAndroid) {
  //   // if (!isAuthenticating) {
  //   //   if (state == AppLifecycleState.resumed) {
  //   //     Get.log("App in : ${state.name}");
  //   //     await checkBiometric();
  //   //     // cameraController != null
  //   //     //     ? initializeCamera(selectedCamera.value)
  //   //     //     : null; //on pause camera is disposed, so we need to call again "issue is only for android"
  //   //   }
  //   // }
  //   // }
  //   // if (Platform.isIOS) {
  //   // if (state == AppLifecycleState.resumed) {
  //   //   Get.log("App in : ${state.name}");
  //   //   await checkBiometric();
  //   //   // cameraController != null
  //   //   //     ? initializeCamera(selectedCamera.value)
  //   //   //     : null; //on pause camera is disposed, so we need to call again "issue is only for android"
  //   // }
  //   // }
  //   super.didChangeAppLifecycleState(state);
  // }

  Future<void> checkBiometric() async {
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
    update();
  }

  Future<void> onAuthenticate() async {
    bool authenticated = false;
    try {
      // update();
      authenticated = await localAuthentication.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
      if (authenticated) {
        Get.rawSnackbar(message: "Authentication Successully");
        Get.offAll(const BottomBarView());
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

  Future<void> goToBiometricSettings() async {
    const settingsiOS = OpenSettingsPlusIOS();
    const settingsAndroid = OpenSettingsPlusAndroid();
    if (Platform.isIOS) {
      var data = await settingsiOS.faceIDAndPasscode();
      Get.log("FaceId $data");
    } else if (Platform.isAndroid) {
      var data = await settingsAndroid.biometricEnroll();
      Get.log("Biometric $data");
    }
    update();
  }
}
