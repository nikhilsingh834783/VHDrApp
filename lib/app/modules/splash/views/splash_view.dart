import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Sizes.init(context);
    Get.put(SplashController());
    return GetBuilder<SplashController>(builder: (controller) {
      return Scaffold(
        backgroundColor: ConstColor.splashBackgroundColor,
        body: Center(
          child: Image.asset(
            ConstAsset.logoImage,
            // scale: 2,
            width: Sizes.crossLength * 0.30,
          ),
        ),
      );
    });
  }
}
