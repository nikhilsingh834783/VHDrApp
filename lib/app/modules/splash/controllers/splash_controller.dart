import 'package:dio/dio.dart' as diopackage;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/biometricauth/views/biometricauth_view.dart';
import 'package:venus/app/modules/bottomBar/views/bottom_bar_view.dart';
import 'package:venus/app/modules/login/views/login_view.dart';

import '../../../core/constant/const_api_url.dart';
import '../../NoInternet/controllers/no_internet_controller.dart';
import '../../NoInternet/views/server_error_view.dart';

class SplashController extends GetxController {
  bool apiCall = false;
  @override
  void onInit() {
    super.onInit();
    // gotToNextPage();
    fetchData();
  }

  Future<void> fetchData() async {
    String url1 = "http://117.217.126.127/weatherforecast";
    apiCall = false;
    var dio = diopackage.Dio();
    try {
      // Try fetching data from the active URL
      final response = await dio
          .get(
            url1,
            options: diopackage.Options(
              validateStatus: (_) => true,
            ),
          )
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        initailUrl = 'http://117.217.126.127/api';
        update();
        gotToNextPage();
      } else {
        fetchDataFromSecondUrl();
        throw Exception('Failed to load data from active URL');
      }
    } catch (e) {
      if (!apiCall) {
        fetchDataFromSecondUrl();
      }
    }
  }

  Future<void> fetchDataFromSecondUrl() async {
    apiCall = true;
    String url2 = "http://103.251.17.214/weatherforecast";
    var dio = diopackage.Dio();

    try {
      final response = await dio
          .get(
            url2,
            options: diopackage.Options(
              validateStatus: (_) => true,
            ),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        initailUrl = 'http://103.251.17.214/api';
        gotToNextPage();
      } else {
        Get.offAll(const ServerErrorView());
        throw Exception('Failed to load data from active URL');
      }
    } catch (e) {
      Get.offAll(const ServerErrorView());
    }
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
