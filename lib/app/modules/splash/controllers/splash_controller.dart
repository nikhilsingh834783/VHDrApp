import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/biometricauth/views/biometricauth_view.dart';
import 'package:venus/app/modules/bottomBar/views/bottom_bar_view.dart';
import 'package:venus/app/modules/login/views/login_view.dart';

import '../../NoInternet/controllers/no_internet_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    gotToNextPage();
  }

  gotToNextPage() async {
    await Future.delayed(const Duration(seconds: 1));
    var control = Get.put(NoInternetController());
    if (control.connectionType.value == 0) {
    } else {
      if (control.connectionType.value == 1 ||
          control.connectionType.value == 2 ||
          control.connectionType.value == 3) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await Future.delayed(const Duration(seconds: 2));
        if (prefs.getString('token') != null &&
            prefs.getString('token') != '') {
          if (prefs.getBool('biometric') == true) {
            Get.offAll(const BiometricauthView());
          } else {
            Get.offAll(const BottomBarView());
          }
        } else {
          Get.offAll(const LoginView());
        }
      }
    }
  }
}
