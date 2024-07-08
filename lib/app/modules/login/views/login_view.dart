import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/forgotpassword/views/forgotpassword_view.dart';

import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/biometric_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        backgroundColor: ConstColor.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: Sizes.crossLength * 0.020,
                right: Sizes.crossLength * 0.020),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: Sizes.crossLength * 0.10,
                  ),
                  Center(
                    child: Image.asset(
                      ConstAsset.logoImage,
                      // scale: 2,
                      width: Sizes.crossLength * 0.260,
                    ),
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.050,
                  ),
                  AppText(
                    text: 'Log In',
                    fontSize: Sizes.px22,
                    fontColor: ConstColor.headingTexColor,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.040,
                  ),
                  AppTextField(
                    hintText: 'Enter Mobile Number',
                    keyboardType: TextInputType.number,
                    textInputFormatter: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    textInputAction: TextInputAction.done,
                    controller: controller.mobileController,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter mobile number.";
                      } else if (value.toString().length < 10) {
                        return "Please enter valid mobile number.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  controller.withPaasword
                      ? SizedBox(
                          height: Sizes.crossLength * 0.025,
                        )
                      : const SizedBox(),
                  controller.withPaasword
                      ? AppTextField(
                          hintText: 'Enter Password',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          controller: controller.passwordController,
                          obscureText: controller.hidePassword,
                          textInputFormatter: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter password.";
                            } else {
                              return null;
                            }
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.hidePassword =
                                  !controller.hidePassword;
                              controller.update();
                            },
                            child: Icon(controller.hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: Sizes.crossLength * 0.008,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.withPaasword = !controller.withPaasword;
                          controller.update();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            bottom: 1, // Space between underline and text
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ConstColor.headingTexColor,
                                width: 1.0, // Underline thickness
                              ),
                            ),
                          ),
                          child: AppText(
                            text: controller.withPaasword
                                ? 'With OTP'
                                : 'With Password',
                            fontColor: ConstColor.headingTexColor,
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.035,
                  ),
                  BiometricAuth.isDeviceSupported
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: 'Biometric Login',
                                  fontColor: ConstColor.blackTextColor,
                                  fontSize: Sizes.px14,
                                  fontWeight: FontWeight.w500,
                                ),
                                FlutterSwitch(
                                  width: Sizes.crossLength * 0.060,
                                  height: Sizes.crossLength * 0.025,
                                  valueFontSize: 12.0,
                                  toggleSize: Sizes.crossLength * 0.018,
                                  value: BiometricAuth.isBiomerticOn ?? false,
                                  activeColor: ConstColor.buttonColor,
                                  onToggle: (val) {
                                    controller.biometricOnChanged(val);
                                    controller.update();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Sizes.crossLength * 0.035,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  // CustomPopupMenu(
                  //   showArrow: false,
                  //   position: PreferredPosition.bottom,
                  //   menuBuilder: () => const ShowCaalenderWidget(),
                  //   pressType: PressType.singleClick,
                  //   verticalMargin: 5,
                  //   horizontalMargin: 20,
                  //   controller: controller.organizationPopupMenuController,
                  //   onTap: () {
                  //     controller.organizationPopupMenuController.showMenu();
                  //   },
                  //   child: SizedBox(
                  //       width: Sizes.crossLength * 0.20,
                  //       child: AppButton(
                  //         radius: 50,
                  //         text: controller.withPaasword
                  //             ? 'Log In'
                  //             : "Generate OTP",
                  //         onPressed: () {
                  //           controller.organizationPopupMenuController
                  //               .showMenu();
                  //           // FocusScope.of(context).unfocus();
                  //           // // Get.to(() => const BottomBarView());
                  //           // if (controller.loginFormKey.currentState!
                  //           //     .validate()) {
                  //           //   controller.validateMobileNo(context);
                  //           // }
                  //         },
                  //       )),
                  // ),
                  SizedBox(
                      width: Sizes.crossLength * 0.20,
                      child: AppButton(
                        radius: 50,
                        text:
                            controller.withPaasword ? 'Log In' : "Generate OTP",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          // Get.to(() => const BottomBarView());
                          if (controller.loginFormKey.currentState!
                              .validate()) {
                            controller.validateMobileNo(context);
                          }
                        },
                      )),
                  SizedBox(
                    height: Sizes.crossLength * 0.025,
                  ),
                  controller.withPaasword
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ForgotpasswordView(),
                                    duration:
                                        const Duration(milliseconds: 700));
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  bottom: 1, // Space between underline and text
                                ),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ConstColor.headingTexColor,
                                      width: 1.0, // Underline thickness
                                    ),
                                  ),
                                ),
                                child: AppText(
                                  text: 'Forgot Password?',
                                  fontColor: ConstColor.headingTexColor,
                                  fontSize: Sizes.px14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
