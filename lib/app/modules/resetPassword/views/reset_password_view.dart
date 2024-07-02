import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:venus/app/app_common_widgets/common_elevated_button.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/common_textform_field.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';
import 'package:venus/app/modules/forgotpassword/views/forgotpassword_view.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordController());
    return GetBuilder<ResetPasswordController>(builder: (controller) {
      return PopScope(
        canPop: false,
        onPopInvoked: (v) {
          Get.offAll(const ForgotpasswordView(),
              duration: const Duration(milliseconds: 700));
        },
        child: Scaffold(
          backgroundColor: ConstColor.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: Sizes.crossLength * 0.020,
                  right: Sizes.crossLength * 0.020),
              child: Form(
                key: controller.resetPasswordKey,
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
                      text: 'Reset Password',
                      fontSize: Sizes.px22,
                      fontColor: ConstColor.headingTexColor,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.040,
                    ),
                    AppTextField(
                      hintText: 'Enter Password',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      controller: controller.newPasswordController,
                      textInputFormatter: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      obscureText: controller.hidePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.hidePassword = !controller.hidePassword;
                          controller.update();
                        },
                        child: Icon(controller.hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      validator: (value) {
                        final passwordRegex =
                            RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{8,}$');
                        if (value!.trim().isEmpty) {
                          return "Please enter password.";
                        } else if (!passwordRegex.hasMatch(value)) {
                          return 'Password must be a minimum of 8 characters in length and include at least one letter and one number.';
                        } else {
                          return null;
                        }
                      },
                      // validator: (value) {
                      //   if (value!.trim().isEmpty) {
                      //     return "Please enter password";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.025,
                    ),
                    AppTextField(
                        hintText: 'Enter Confirm Password',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        controller: controller.confirmPasswordController,
                        textInputFormatter: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        obscureText: controller.hideConfirmPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.hideConfirmPassword =
                                !controller.hideConfirmPassword;
                            controller.update();
                          },
                          child: Icon(controller.hideConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter confirm password";
                          } else if (value.toString() !=
                              controller.newPasswordController.text.trim()) {
                            return "Password didn't match.";
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: Sizes.crossLength * 0.040,
                    ),
                    SizedBox(
                      width: Sizes.crossLength * 0.20,
                      child: AppButton(
                        radius: 50,
                        text: "Reset Password",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (controller.resetPasswordKey.currentState!
                              .validate()) {
                            controller.resetPassworApi();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: Sizes.crossLength * 0.020,
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Get.offAll(const ForgotpasswordView(),
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
        ),
      );
    });
  }
}
