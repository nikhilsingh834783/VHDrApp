import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as diopackage;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/NoInternet/views/no_internet_view.dart';
import 'package:venus/app/modules/biometricauth/views/biometricauth_view.dart';
import 'package:venus/app/modules/splash/views/splash_view.dart';

import '../../../core/constant/const_api_url.dart';
import '../../bottomBar/views/bottom_bar_view.dart';
import '../../login/views/login_view.dart';

class NoInternetController extends GetxController {
  //0 = No Internet
  //1 = WIFI Connected
  //2 = Mobile Data Connected

  // Variable
  var connectionType = 0.obs;

  final Connectivity connectivity = Connectivity();

  late StreamSubscription _streamSubscription;
  bool isOpenInternetConnectionDialog = false;
  bool apiCall = false;

  @override
  void onInit() async {
    super.onInit();
    // Function Call
    await getConnectivityType();
    // setScreenLog(screenName: ScreenNames.noInternet);
    _streamSubscription =
        connectivity.onConnectivityChanged.listen(_updateState);
  }

  // Connectivity Type Function
  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
      // CheckInternet.isNotAvailable =
      //     connectivityResult == ConnectivityResult.none;
      update();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // Function Call
    return _updateState(connectivityResult);
  }

  // Update State Function
  _updateState(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      // WIFI
      case ConnectivityResult.wifi:
        connectionType.value = ConnectivityResult.wifi.index;
        checkAndCloseDialog();
        break;
      // Mobile
      case ConnectivityResult.mobile:
        connectionType.value = ConnectivityResult.mobile.index;
        checkAndCloseDialog();
        break;
      // Ethernet
      case ConnectivityResult.ethernet:
        connectionType.value = ConnectivityResult.ethernet.index;
        checkAndCloseDialog();
        break;
      // None
      case ConnectivityResult.none:
        connectionType.value = ConnectivityResult.none.index;
        if (isOpenInternetConnectionDialog == false) {
          isOpenInternetConnectionDialog = true;
          update();
          // Get.toNamed(Routes.);
          Get.to(const NoInternetView());
        }
        break;
      case ConnectivityResult.bluetooth:
        connectionType.value = ConnectivityResult.bluetooth.index;
        break;
      case ConnectivityResult.vpn:
        connectionType.value = ConnectivityResult.vpn.index;
        break;

      case ConnectivityResult.other:
        connectionType.value = ConnectivityResult.other.index;
        break;
      default:
        Get.rawSnackbar(message: "Failed to get connection type");
        // Get.showSnackbar(const GetSnackBar(
        //     title: 'Error', message: 'Failed to get connection type'));
        break;
    }
    update();
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }

  void checkAndCloseDialog() {
    if (isOpenInternetConnectionDialog) {
      isOpenInternetConnectionDialog = false;
      // Get.offAllNamed(Routes.SPLASH);
      Get.offAll(const SplashView());
      update();
      Get.back();
    }
  }

  Future<void> fetchData() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
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
        // EasyLoading.dismiss();
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
        // EasyLoading.dismiss();
        gotToNextPage();
      } else {
        throw Exception('Failed to load data from active URL');
      }
    } catch (e) {
      EasyLoading.dismiss();
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
        await Future.delayed(const Duration(seconds: 1));
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

// Future<void> setScreenLog({String screenName = ""}) async {
//   if (screenName.trim().isNotEmpty) {
//     try {
//       await FirebaseAnalytics.instance.logScreenView(
//           callOptions: AnalyticsCallOptions(global: true),
//           screenName: screenName.replaceAll("/", ""));
//     } on Exception catch (e) {
//       print("FirebaseAnalytics.instance.logScreenView $e");
//       // TODO
//     }
//     if (kDebugMode) {
//       Get.log("::::::::::::::::::::::::::::::::");
//       Get.log("FirebaseAnalytics Screen Name : $screenName");
//       Get.log("::::::::::::::::::::::::::::::::");
//     }
//   }
// }
