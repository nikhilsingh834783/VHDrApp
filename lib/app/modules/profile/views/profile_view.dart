import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/profile/controllers/profile_controller.dart';
import 'package:venus/app/modules/profile/views/edit_profile_view.dart';
import '../../../app_common_widgets/common_elevated_button.dart';
import '../../../app_common_widgets/common_text.dart';
import '../../../app_common_widgets/common_textform_field.dart';
import '../../../app_common_widgets/sizer_constant.dart';
import '../../../core/constant/asset_constant.dart';
import '../../../core/them/const_color.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key, required String email});
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Profile',
              fontSize: Sizes.px22,
              fontColor: ConstColor.headingTexColor,
              fontWeight: FontWeight.w800,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 2,
            excludeHeaderSemantics: false,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.grey,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: false,
          // drawer: const MyDrawer(),
          body: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Form(
                  // key: controller.profileForKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.crossLength * 0.020,
                      right: Sizes.crossLength * 0.020,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.selectImage(context);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: Sizes.crossLength * 0.092,
                                  height: Sizes.crossLength * 0.092,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: ConstColor.hintTextColor),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  /// Image Changed By Divyanshi
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: controller.imageBytes != null
                                        ? Image.memory(controller.imageBytes!,
                                      fit: BoxFit.cover,)
                                    // Image.file(
                                    //         File(controller.selectedImagePath!),
                                    //         fit: BoxFit.cover,
                                    //         width: double.infinity,
                                    //         height: double.infinity,
                                    //       )
                                        : Image.asset(
                                            ConstAsset.profileImage,
                                            width: Sizes.crossLength * 0.072,
                                            height: Sizes.crossLength * 0.024,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  top: Sizes.crossLength * 0.055,
                                  left: Sizes.crossLength * 0.070,
                                  child: Container(
                                    width: Sizes.crossLength * 0.036,
                                    height: Sizes.crossLength * 0.036,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: ConstColor.blackColor00313C),
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: Sizes.crossLength * 0.024,
                                      color: ConstColor.blackColor00313C,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        Container(
                          height: Sizes.crossLength * 0.070,
                          width: Sizes.crossLength * 0.380,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ConstColor.hintTextColor, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: Row(
                                  children: [
                                    AppText(
                                      text: 'Biometric Login',
                                      fontSize: Sizes.px15,
                                      fontWeight: FontWeight.w600,
                                      fontColor: ConstColor.black4B4D4F,
                                    ),
                                    Spacer(),
                                    Obx(
                                      () => FlutterSwitch(
                                        width: Sizes.crossLength * 0.060,
                                        height: Sizes.crossLength * 0.025,
                                        valueFontSize: 12.0,
                                        toggleSize: Sizes.crossLength * 0.018,
                                        value: controller.isBiometricOn.value,
                                        activeColor: ConstColor.buttonColor,
                                        onToggle: (val) {
                                          controller.biometricOnChanged(val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 5, 15, 0),
                                child: AppText(
                                  text:
                                      'Any registered biometric on your device will have access to this app.',
                                  fontSize: Sizes.px10,
                                  fontWeight: FontWeight.w500,
                                  fontColor: ConstColor.black4B4D4F,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Doctor Name',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          controller: controller.nameController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          enabled: false,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter Doctor Name.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Mobile Number',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          hintText: 'Enter Mobile Number',
                          controller: controller.mobileController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          enabled: false,
                          keyboardType: TextInputType.number,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(10),
                          ],
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
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Email Address',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),

                        AppTextField(
                          controller: controller.emailController,
                          hintText: 'Enter Email Address',
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          enabled: false,
                          validator: (val) {
                            String pattern =
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                            RegExp regex = RegExp(pattern);

                            if (val == null || val.trim().isEmpty) {
                              return "Please enter Email Address.";
                            } else if (!regex.hasMatch(val.trim())) {
                              return "Please enter a valid Email Address.";
                            } else {
                              return null; // Valid case
                            }
                          },
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Doctor Speciality',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          hintText: 'Enter Doctor Speciality',
                          controller: controller.doctorSpecialityController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          enabled: false,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter Doctor Speciality.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Degree',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          enabled: false,
                          hintText: 'Enter Degree',
                          controller: controller.degreeController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter Degree.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Registration No',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          enabled: false,
                          hintText: 'Enter Registration No',
                          controller: controller.registrationController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter Registration number.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Date Of Birth',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          enabled: false,
                          controller: controller.dateOfOperation,
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Address',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          enabled: false,
                          hintText: 'Enter Address',
                          controller: controller.addressController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter Address.";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: getDynamicHeight(size: 0.14)),
                                    child: AppText(
                                      text: 'City',
                                      fontSize: Sizes.px14,
                                      fontWeight: FontWeight.w600,
                                      fontColor: ConstColor.black4B4D4F,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Sizes.crossLength * 0.010,
                                  ),
                                  AppTextField(
                                    enabled: false,
                                    hintText: 'Enter City',
                                    controller: controller.cityController,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    validator: (val) {
                                      if (val!.trim().isEmpty) {
                                        return "Please enter City.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Sizes.crossLength * 0.020,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: getDynamicHeight(size: 0.12)),
                                    child: AppText(
                                      text: 'State',
                                      fontSize: Sizes.px14,
                                      fontWeight: FontWeight.w600,
                                      fontColor: ConstColor.black4B4D4F,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Sizes.crossLength * 0.010,
                                  ),
                                  AppTextField(
                                    enabled: false,
                                    hintText: 'Enter State',
                                    controller: controller.stateController,
                                    onTapOutside: (event) {
                                      FocusScope.of(context).unfocus();
                                    },
                                    validator: (val) {
                                      if (val!.trim().isEmpty) {
                                        return "Please enter State.";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: getDynamicHeight(size: 0.015)),
                child: MediaQuery.of(context).viewInsets.bottom != 0
                    ? const SizedBox()
                    : SizedBox(
                        height: getDynamicHeight(size: 0.045),
                        width: getDynamicHeight(size: 0.170),
                        child: AppButton(
                          radius: 50,
                          onPressed: () {
                            Get.to(() => EditProfileView());
                          },
                          text: "Edit Profile",
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
