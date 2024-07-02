import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_elevated_button.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/them/const_color.dart';

import '../../../core/constant/asset_constant.dart';
import '../controllers/biometricauth_controller.dart';

class BiometricauthView extends GetView<BiometricauthController> {
  const BiometricauthView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(BiometricauthController());
    return GetBuilder(builder: (BiometricauthController controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getDynamicHeight(size: 0.024),
                    vertical: getDynamicHeight(size: 0.030),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Image.asset(
                          ConstAsset.logoImage, // ConstAsset.tfgLogoPNG,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 5,
                        child: AppText(
                          text: "Venus",
                          textAlign: TextAlign.center,
                          fontSize: getDynamicHeight(size: 0.020),
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.buttonColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getDynamicHeight(size: 0.040),
                  ),
                  child: AppText(
                    text: "Hi",
                    textAlign: TextAlign.center,
                    fontSize: getDynamicHeight(size: 0.024),
                    fontWeight: FontWeight.w400,
                    // fontFamily: FontConst.museoSans,
                    fontColor: const Color(0xff00313C),
                  ),
                ),
                AppText(
                  text: controller.userName,
                  textAlign: TextAlign.center,
                  fontSize: getDynamicHeight(size: 0.024),
                  fontWeight: FontWeight.w600,
                  fontColor: const Color(0xff00313C),
                ),
                const Spacer(flex: 5),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AppText(
                        text: "Unlock Biometric",
                        textAlign: TextAlign.center,
                        fontSize: getDynamicHeight(size: 0.020),
                        fontWeight: FontWeight.w400,
                        fontColor: const Color(0xff00313C),
                      ),
                    ),
                    SizedBox(
                      height: getDynamicHeight(size: 0.020),
                    ),
                    StreamBuilder(
                      stream: controller.localAuthentication
                          .getAvailableBiometrics()
                          .asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Flexible(
                              child: (Platform.isAndroid)
                                  ? GestureDetector(
                                      onTap: () {
                                        controller.onAuthenticate();
                                      },
                                      child: SvgPicture.asset(
                                          ConstAsset.biometricIcon))
                                  : InkWell(
                                      onTap: () {
                                        controller.onAuthenticate();
                                      },
                                      child: SvgPicture.asset(
                                          ConstAsset.faceIcon)));
                        } else {
                          return Center(
                            child: SizedBox(
                              width: getDynamicHeight(size: 0.20),
                              child: AppButton(
                                text: "Set Biometric",
                                fontSize: Sizes.px16,
                                radius: 50,
                                fontWeight: FontWeight.w400,
                                onPressed: () {
                                  controller.goToBiometricSettings();
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: getDynamicHeight(size: 0.020),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.withPaasword = !controller.withPaasword;
                            // controller.update();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 1, // Space between underline and text
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ConstColor.redColor,
                                  width: 1.0, // Underline thickness
                                ),
                              ),
                            ),
                            child: AppText(
                              text: 'Logout',
                              fontColor: ConstColor.redColor,
                              fontSize: Sizes.px14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                    // Center(
                    //   child: SizedBox(
                    //     width: getDynamicHeight(size: 0.120),
                    //     child: AppButton(
                    //       isDelete: true,
                    //       radius: 50,
                    //       text: "Logout",
                    //       fontSize: Sizes.px16,
                    //       fontWeight: FontWeight.w400,
                    //       onPressed: () {
                    //         // checkBiometricandLogOut();
                    //         // Get.offAllNamed(Routes.LOGIN);
                    //       },
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
