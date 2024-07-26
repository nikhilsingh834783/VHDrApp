import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/NoInternet/views/no_internet_view.dart';
import 'package:venus/app/modules/splash/views/splash_view.dart';

class NoInternetController extends GetxController {
  //0 = No Internet
  //1 = WIFI Connected
  //2 = Mobile Data Connected

  // Variable
  var connectionType = 0.obs;

  final Connectivity connectivity = Connectivity();

  late StreamSubscription _streamSubscription;
  bool isOpenInternetConnectionDialog = false;

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
