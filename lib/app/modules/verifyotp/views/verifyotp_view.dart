import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:venus/app/app_common_widgets/app_font_name.dart';
import 'package:venus/app/app_common_widgets/common_elevated_button.dart';
import 'package:venus/app/app_common_widgets/common_text.dart';
import 'package:venus/app/app_common_widgets/sizer_constant.dart';
import 'package:venus/app/core/constant/asset_constant.dart';
import 'package:venus/app/core/them/const_color.dart';

import '../controllers/verifyotp_controller.dart';

class VerifyotpView extends GetView<VerifyotpController> {
  const VerifyotpView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(VerifyotpController());
    return GetBuilder<VerifyotpController>(builder: (controller) {
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
                    text: 'Enter OTP',
                    fontSize: Sizes.px22,
                    fontColor: ConstColor.headingTexColor,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.015,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: Sizes.px14,
                          height: 1.5,
                          color: ConstColor.lightBlackColor,
                          fontFamily: CommonFontStyle.plusJakartaSans,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'We have  sent you an OTP on ',
                        ),
                        TextSpan(
                          text: '+91 ${controller.mobileNo}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: ConstColor.blackColor,
                            fontFamily: CommonFontStyle.plusJakartaSans,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.040,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Sizes.crossLength * 0.025,
                        right: Sizes.crossLength * 0.025),
                    child: PinCodeTextField(
                      appContext: Get.context!,
                      textStyle: TextStyle(
                          fontSize: Sizes.px22,
                          fontWeight: FontWeight.w800,
                          fontFamily: CommonFontStyle.plusJakartaSans),
                      length: 6,
                      keyboardType: TextInputType.number,
                      controller: controller.otpController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (val) {
                        // controller.otpResError = null;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.update();
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter otp.";
                        } else if (value.length < 6) {
                          return "Please enter valid otp.";
                        } else {
                          return null;
                        }
                      },
                      errorTextMargin: EdgeInsets.only(
                          top: Sizes.crossLength * 0.050, left: 10),
                      pinTheme: PinTheme(
                          fieldHeight: 50,
                          activeBorderWidth: 1.0,
                          inactiveBorderWidth: 1.0,
                          selectedBorderWidth: 1.0,
                          borderWidth: 1.0,
                          borderRadius: BorderRadius.circular(12),
                          shape: PinCodeFieldShape.box,
                          activeColor: ConstColor.borderColor,
                          inactiveColor: ConstColor.borderColor,
                          activeFillColor: ConstColor.borderColor,
                          inactiveFillColor: ConstColor.borderColor,
                          selectedColor: ConstColor.headingTexColor,
                          fieldWidth: 45),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: Sizes.crossLength * 0.055,
                  //       right: Sizes.crossLength * 0.055),
                  //   child: PinCodeTextField(
                  //     appContext: Get.context!,
                  //     textStyle: TextStyle(
                  //         fontSize: Sizes.px25,
                  //         fontWeight: FontWeight.w800,
                  //         fontFamily: CommonFontStyle.plusJakartaSans),
                  //     length: 6,
                  //     keyboardType: TextInputType.number,
                  //     controller: controller.otpController,
                  //     inputFormatters: <TextInputFormatter>[
                  //       FilteringTextInputFormatter.digitsOnly,
                  //     ],
                  //     onChanged: (val) {
                  //       // controller.otpResError = null;
                  //       WidgetsBinding.instance.addPostFrameCallback((_) {
                  //         controller.update();
                  //       });
                  //     },
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return "Please enter otp.";
                  //       } else if (value.length < 6) {
                  //         return "Please enter valid otp.";
                  //       } else {
                  //         return null;
                  //       }
                  //     },
                  //     errorTextMargin: EdgeInsets.only(
                  //         top: Sizes.crossLength * 0.050, left: 10),
                  //     pinTheme: PinTheme(
                  //         fieldHeight: 50,
                  //         activeBorderWidth: 1.0,
                  //         inactiveBorderWidth: 1.0,
                  //         selectedBorderWidth: 1.0,
                  //         borderWidth: 1.0,
                  //         borderRadius: BorderRadius.circular(12),
                  //         shape: PinCodeFieldShape.box,
                  //         activeColor: ConstColor.borderColor,
                  //         inactiveColor: ConstColor.borderColor,
                  //         activeFillColor: ConstColor.borderColor,
                  //         inactiveFillColor: ConstColor.borderColor,
                  //         selectedColor: ConstColor.headingTexColor,
                  //         fieldWidth: 55),
                  //   ),
                  // ),
                  SizedBox(
                    height: Sizes.crossLength * 0.015,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        AppText(
                          text: 'Request new OTP in',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        controller.enableResendOtp.value
                            ? GestureDetector(
                                onTap: () async {
                                  controller.otpController.clear();
                                  controller.update();
                                  // controller.loginFormKey.currentState!.reset();
                                  controller.resendApiCall(context);
                                  // controller.loginFormKey.currentState!.reset();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom:
                                        1, // Space between underline and text
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
                                    text: 'Resend',
                                    fontColor: ConstColor.headingTexColor,
                                    fontSize: Sizes.px14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            : AppText(
                                text:
                                    "0${(controller.secondsRemaining.value / 60).floor().toStringAsFixed(0)} : ${(controller.secondsRemaining.value % 60).toString().length == 1 ? '0' : ''}${controller.secondsRemaining.value % 60}",
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w700,
                                fontColor: ConstColor.redColor,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.030,
                  ),
                  SizedBox(
                    width: Sizes.crossLength * 0.20,
                    child: AppButton(
                      radius: 50,
                      text: "Verify",
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (controller.loginFormKey.currentState!.validate()) {
                          controller.verifyOtp();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Sizes.crossLength * 0.020,
                  ),
                  GestureDetector(
                    onTap: () {
                      // FocusManager.instance.primaryFocus?.unfocus();
                      // Navigator.pop(context);
                      Get.back();
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
