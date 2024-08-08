import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'app/core/them/const_color.dart';
import 'app/modules/NoInternet/bindings/no_internet_binding.dart';
import 'app/modules/NoInternet/controllers/no_internet_controller.dart';
import 'app/modules/opdAppointments/model/ment_model.dart';
import 'app/routes/app_pages.dart';

RxBool hideBottomBar = false.obs;
List<AppointMentLsitData> appointMentsDate = [];
List<AppointMentLsitData> procedureDates = [];
int calenderType = 0;
bool previousDateEnable = false;
//calenderType = 0 for appointments page events calender
//calenderType = 1 for procedure page events calender
//calenderType = 2 for normal page calender

void main() {
  runApp(
    Builder(
      builder: (context) {
        Get.put(NoInternetController());
        return GetMaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: ConstColor.whiteColor),
          initialBinding: NoInternetBinding(),
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          navigatorObservers: [
            NavigatorObserver(),
          ],
        );
      },
    ),
  );
}
