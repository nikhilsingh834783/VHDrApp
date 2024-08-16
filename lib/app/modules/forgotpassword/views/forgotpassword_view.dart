import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/login/views/login_view.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/forgotpassword_controller.dart';

class ForgotpasswordView extends GetView<ForgotpasswordController> {
  const ForgotpasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ForgotpasswordController());
    return GetBuilder<ForgotpasswordController>(builder: (controller) {
      return PopScope(
        canPop: false,
        onPopInvoked: (v) {
          Get.offAll(const LoginView(),
              duration: const Duration(milliseconds: 700));
        },
        child: Scaffold(
          backgroundColor: ConstColor.whiteColor,
          body: Padding(
            padding: EdgeInsets.only(
                left: Sizes.crossLength * 0.020,
                right: Sizes.crossLength * 0.020),
            child: Form(
              key: controller.generateOtpKey,
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
                    text: 'Generate OTP',
                    fontSize: Sizes.px22,
                    fontColor: ConstColor.headingTexColor,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.040,
                  ),
                  AppTextField(
                    hintText: 'Enter Mobile Number',
                    controller: controller.mobileController,
                    keyboardType: TextInputType.number,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter mobile number.";
                      } else if (value.toString().length < 10) {
                        return "Please enter valid mobile number.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.040,
                  ),
                  SizedBox(
                    width: Sizes.crossLength * 0.20,
                    child: AppButton(
                      radius: 50,
                      text: "Continue",
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        // FocusManager.instance.primaryFocus?.unfocus();
                        if (controller.generateOtpKey.currentState!
                            .validate()) {
                          controller.validateMobileNo();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.020,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.back();
                      Get.offAll(const LoginView(),
                          duration: const Duration(milliseconds: 700));
                    },
                    child: AppText(
                      text: 'Cancel',
                      fontSize: Sizes.px14,
                      fontColor: ConstColor.blackTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
