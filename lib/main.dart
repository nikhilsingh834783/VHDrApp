import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app/modules/NoInternet/bindings/no_internet_binding.dart';
import 'app/modules/NoInternet/controllers/no_internet_controller.dart';
import 'app/routes/app_pages.dart';

RxBool hideBottomBar = false.obs;

void main() {
  runApp(
    Builder(builder: (context) {
      Get.put(NoInternetController());
      return GetMaterialApp(
        initialBinding: NoInternetBinding(),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        navigatorObservers: [
          NavigatorObserver(),
        ],
      );
    }),
  );
}
