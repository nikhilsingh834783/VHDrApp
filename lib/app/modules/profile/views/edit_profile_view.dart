// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:venus/app/modules/profile/views/widget/degree.dart';
// import 'package:venus/app/modules/profile/views/widget/doctor_specialist.dart';
// import '../../../../main.dart';
// import '../../../app_common_widgets/common_elevated_button.dart';
// import '../../../app_common_widgets/common_text.dart';
// import '../../../app_common_widgets/common_textform_field.dart';
// import '../../../app_common_widgets/custom_pop_menu.dart';
// import '../../../app_common_widgets/sizer_constant.dart';
// import '../../../core/constant/asset_constant.dart';
// import '../../../core/them/const_color.dart';
// import '../controllers/profile_controller.dart';
//
// class EditProfileView extends GetView<ProfileController> {
//   const EditProfileView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProfileController());
//     return GetBuilder<ProfileController>(
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             title: AppText(
//               text: 'Edit Profile',
//               fontSize: Sizes.px22,
//               fontColor: ConstColor.headingTexColor,
//               fontWeight: FontWeight.w800,
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.white,
//             elevation: 2,
//             excludeHeaderSemantics: false,
//             surfaceTintColor: Colors.white,
//             shadowColor: Colors.grey,
//             leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: () => Navigator.pop(context)),
//           ),
//           backgroundColor: Colors.white,
//           // resizeToAvoidBottomInset: false,
//           // drawer: const MyDrawer(),
//           body: Stack(
//             clipBehavior: Clip.none,
//             alignment: Alignment.bottomCenter,
//             children: [
//               SingleChildScrollView(
//                 child: Form(
//                   key: controller.profileForKey,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       left: Sizes.crossLength * 0.020,
//                       right: Sizes.crossLength * 0.020,
//                       bottom: MediaQuery.of(context).viewInsets.bottom,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               controller.selectImage(context);
//                             },
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Container(
//                                   width: Sizes.crossLength * 0.092,
//                                   height: Sizes.crossLength * 0.092,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         width: 1,
//                                         color: ConstColor.hintTextColor),
//                                     borderRadius: const BorderRadius.all(
//                                       Radius.circular(20),
//                                     ),
//                                   ),
//                                   child:
//
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: controller.imageBytes != null
//                                         ? Image.memory(controller.imageBytes!,
//                                     fit: BoxFit.cover,)
//                                     // Image.file(
//                                     //         File(controller.selectedImagePath!),
//                                     //         fit: BoxFit.cover,
//                                     //         width: double.infinity,
//                                     //         height: double.infinity,
//                                     //       )
//                                         :  Image.asset(
//                                             ConstAsset.profileImage,
//                                             width: Sizes.crossLength * 0.072,
//                                             height: Sizes.crossLength * 0.024,
//                                           ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: Sizes.crossLength * 0.055,
//                                   left: Sizes.crossLength * 0.070,
//                                   child: Container(
//                                     width: Sizes.crossLength * 0.036,
//                                     height: Sizes.crossLength * 0.036,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 1,
//                                           color: ConstColor.blackColor00313C),
//                                       color: Colors.white,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(
//                                       Icons.camera_alt,
//                                       size: Sizes.crossLength * 0.024,
//                                       color: ConstColor.blackColor00313C,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Doctor Name',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         AppTextField(
//                           controller: controller.nameController,
//                           onTapOutside: (event) {
//                             FocusScope.of(context).unfocus();
//                           },
//                           validator: (val) {
//                             if (val!.trim().isEmpty) {
//                               return "Please enter Doctor Name.";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Mobile Number',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         AppTextField(
//                           hintText: 'Enter Mobile Number',
//                           controller: controller.mobileController,
//                           onTapOutside: (event) {
//                             FocusScope.of(context).unfocus();
//                           },
//                           keyboardType: TextInputType.number,
//                           textInputFormatter: [
//                             LengthLimitingTextInputFormatter(10),
//                           ],
//                           validator: (value) {
//                             if (value!.trim().isEmpty) {
//                               return "Please enter mobile number.";
//                             } else if (value.toString().length < 10) {
//                               return "Please enter valid mobile number.";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Email Address',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         // AppTextField(
//                         //   controller: controller.emailController,
//                         //   hintText: 'Enter Email Address',
//                         //   onTapOutside: (event) {
//                         //     FocusScope.of(context).unfocus();
//                         //   },
//                         //   validator: (val) {
//                         //     if (val!.trim().isEmpty) {
//                         //       return "Please enter Email Address.";
//                         //     } else {
//                         //       return null;
//                         //     }
//                         //   },
//                         // ),
//
//                         AppTextField(
//                           controller: controller.emailController,
//                           hintText: 'Enter Email Address',
//                           onTapOutside: (event) {
//                             FocusScope.of(context).unfocus();
//                           },
//                           validator: (val) {
//                             String pattern =
//                                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//                             RegExp regex = RegExp(pattern);
//                             if (val == null || val.trim().isEmpty) {
//                               return "Please enter email address.";
//                             } else if (!regex.hasMatch(val.trim())) {
//                               return "Please enter a valid email address.";
//                             } else {
//                               return null; // Valid case
//                             }
//                           },
//                         ),
//
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Doctor Speciality',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         CustomPopupMenu(
//                           showArrow: false,
//                           position: PreferredPosition.bottom,
//                           menuBuilder: () => const DoctorSpecialist(),
//                           pressType: PressType.singleClick,
//                           verticalMargin: 5,
//                           horizontalMargin: 20,
//                           controller: controller.doctorSpecialistNameController,
//                           onTap: () {
//                             controller.doctorSpecialistNameController
//                                 .showMenu();
//                           },
//                           child: AppTextField(
//                             onTap: () {
//                               controller.doctorSpecialistNameController
//                                   .showMenu();
//                             },
//                             hintText: 'Select Organization',
//                             controller: controller.doctorSpecialityController,
//                             isReadOnly: true,
//                             validator: (val) {
//                               if (val!.trim().isEmpty) {
//                                 return "Please select doctorSpeciality.";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             suffixIcon: Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: SvgPicture.asset(
//                                 ConstAsset.down,
//                                 height: 20,
//                                 width: 20,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Degree',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         CustomPopupMenu(
//                           showArrow: false,
//                           position: PreferredPosition.bottom,
//                           menuBuilder: () => const DegreeList(),
//                           pressType: PressType.singleClick,
//                           verticalMargin: 5,
//                           horizontalMargin: 20,
//                           controller: controller.degreeNameController,
//                           onTap: () {
//                             controller.degreeNameController.showMenu();
//                           },
//                           child: AppTextField(
//                             onTap: () {
//                               controller.degreeNameController.showMenu();
//                             },
//                             hintText: 'Select Degree',
//                             controller: controller.degreeController,
//                             isReadOnly: true,
//                             validator: (val) {
//                               if (val!.trim().isEmpty) {
//                                 return "Please select degree.";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             suffixIcon: Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: SvgPicture.asset(
//                                 ConstAsset.down,
//                                 height: 20,
//                                 width: 20,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Registration No',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         AppTextField(
//                           hintText: 'Enter Registration No',
//                           controller: controller.registrationController,
//                           onTapOutside: (event) {
//                             FocusScope.of(context).unfocus();
//                           },
//                           validator: (val) {
//                             if (val!.trim().isEmpty) {
//                               return "Please enter Registration number.";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         // AppText(
//                         //   text: 'Date Of Birth',
//                         //   fontSize: Sizes.px14,
//                         //   fontWeight: FontWeight.w600,
//                         //   fontColor: ConstColor.black4B4D4F,
//                         // ),
//                         // SizedBox(
//                         //   height: Sizes.crossLength * 0.010,
//                         // ),
//                         // CustomPopupMenu(
//                         //   showArrow: false,
//                         //   position: PreferredPosition.bottom,
//                         //   menuBuilder: () => const SelectBirthDate(),
//                         //   pressType: PressType.singleClick,
//                         //   verticalMargin: 5,
//                         //   horizontalMargin: 20,
//                         //   controller: controller.selectDateController,
//                         //   onTap: () {
//                         //     controller.selectDateController.showMenu();
//                         //   },
//                         //   child: AppTextField(
//                         //     hintText: 'Select Date',
//                         //     controller: controller.dateOfOperation,
//                         //     isReadOnly: true,
//                         //     validator: (val) {
//                         //       if (val!.trim().isEmpty) {
//                         //         return "Please enter date of birth.";
//                         //       } else {
//                         //         return null;
//                         //       }
//                         //     },
//                         //     onTap: () {
//                         //       controller.selectDateController.showMenu();
//                         //     },
//                         //     suffixIcon: Padding(
//                         //       padding: const EdgeInsets.all(12.0),
//                         //       child: SvgPicture.asset(
//                         //         ConstAsset.calender,
//                         //         height: 20,
//                         //         width: 20,
//                         //         fit: BoxFit.cover,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                         AppText(
//                           text: 'Date of Birth',
//                           fontSize: Sizes.px15,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         AppTextField(
//                           hintText: 'Date of Birth',
//                           controller: controller.dateOfOperation,
//                           isReadOnly: true,
//                           // validator: (val) {
//                           //   if (val!.trim().isEmpty) {
//                           //     return "Please enter operation date.";
//                           //   } else {
//                           //     return null;
//                           //   }
//                           // },
//                           onTap: () {
//                             previousDateEnable = true;
//                             controller.selectDateBottomSheet();
//                           },
//                           suffixIcon: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: SvgPicture.asset(
//                               ConstAsset.calender,
//                               height: 20,
//                               width: 20,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         AppText(
//                           text: 'Address',
//                           fontSize: Sizes.px14,
//                           fontWeight: FontWeight.w600,
//                           fontColor: ConstColor.black4B4D4F,
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.010,
//                         ),
//                         AppTextField(
//                           hintText: 'Enter Address',
//                           controller: controller.addressController,
//                           onTapOutside: (event) {
//                             FocusScope.of(context).unfocus();
//                           },
//                           validator: (val) {
//                             if (val!.trim().isEmpty) {
//                               return "Please enter Address.";
//                             } else {
//                               return null;
//                             }
//                           },
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.025,
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         right: getDynamicHeight(size: 0.14)),
//                                     child: AppText(
//                                       text: 'City',
//                                       fontSize: Sizes.px14,
//                                       fontWeight: FontWeight.w600,
//                                       fontColor: ConstColor.black4B4D4F,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: Sizes.crossLength * 0.010,
//                                   ),
//                                   AppTextField(
//                                     hintText: 'Enter City',
//                                     controller: controller.cityController,
//                                     onTapOutside: (event) {
//                                       FocusScope.of(context).unfocus();
//                                     },
//                                     validator: (val) {
//                                       if (val!.trim().isEmpty) {
//                                         return "Please enter City.";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               width: Sizes.crossLength * 0.020,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         right: getDynamicHeight(size: 0.12)),
//                                     child: AppText(
//                                       text: 'State',
//                                       fontSize: Sizes.px14,
//                                       fontWeight: FontWeight.w600,
//                                       fontColor: ConstColor.black4B4D4F,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: Sizes.crossLength * 0.010,
//                                   ),
//                                   AppTextField(
//                                     hintText: 'Enter State',
//                                     controller: controller.stateController,
//                                     onTapOutside: (event) {
//                                       FocusScope.of(context).unfocus();
//                                     },
//                                     validator: (val) {
//                                       if (val!.trim().isEmpty) {
//                                         return "Please enter State.";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: Sizes.crossLength * 0.2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(bottom: getDynamicHeight(size: 0.015)),
//                 child: MediaQuery.of(context).viewInsets.bottom != 0
//                     ? const SizedBox()
//                     : SizedBox(
//                         height: getDynamicHeight(size: 0.045),
//                         width: getDynamicHeight(size: 0.170),
//                         child: AppButton(
//                           radius: 50,
//                           onPressed: () {
//                             if (controller.profileForKey.currentState!
//                                 .validate()) {
//                               // controller.createProfile();
//                               Navigator.pop(context);
//                               controller.editProfile(context: context);
//                             }
//                           },
//                           text: "Save",
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
// //9033390020
/// View changed By Madhavi
// ignore_for_file: dangling_library_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../app_common_widgets/common_elevated_button.dart';
import '../../../app_common_widgets/common_text.dart';
import '../../../app_common_widgets/common_textform_field.dart';
import '../../../app_common_widgets/sizer_constant.dart';
import '../../../core/constant/asset_constant.dart';
import '../../../core/them/const_color.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Edit Profile',
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
                onPressed: () => Navigator.pop(context)),
          ),
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: false,
          // drawer: const MyDrawer(),
          body: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
               scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Form(
                  key: controller.profileForKey,
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
                                        ? Image.memory(
                                      controller.imageBytes!,
                                      fit: BoxFit.cover,
                                    )
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
                        // AppTextField(
                        //   controller: controller.emailController,
                        //   hintText: 'Enter Email Address',
                        //   onTapOutside: (event) {
                        //     FocusScope.of(context).unfocus();
                        //   },
                        //   validator: (val) {
                        //     if (val!.trim().isEmpty) {
                        //       return "Please enter Email Address.";
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),

                        AppTextField(
                          controller: controller.emailController,
                          hintText: 'Enter Email Address',
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (val) {
                            String pattern =
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                            RegExp regex = RegExp(pattern);
                            if (val == null || val.trim().isEmpty) {
                              return "Please enter email address.";
                            } else if (!regex.hasMatch(val.trim())) {
                              return "Please enter a valid email address.";
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
                          onTap: () {
                            controller.selectDoctorSpecialistBottom();
                          },
                          isReadOnly: true,
                          controller: controller.doctorSpecialityController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please select doctorSpeciality.";
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Select DoctorSpeciality',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              ConstAsset.down,
                            ),
                          ),
                        ),
                        // CustomPopupMenu(
                        //   showArrow: false,
                        //   position: PreferredPosition.bottom,
                        //   menuBuilder: () => const DoctorSpecialist(),
                        //   pressType: PressType.singleClick,
                        //   verticalMargin: 5,
                        //   horizontalMargin: 20,
                        //   controller: controller.doctorSpecialistNameController,
                        //   onTap: () {
                        //     controller.doctorSpecialistNameController
                        //         .showMenu();
                        //   },
                        //   child: AppTextField(
                        //     onTap: () {
                        //       controller.doctorSpecialistNameController
                        //           .showMenu();
                        //     },
                        //     hintText: 'Select Organization',
                        //     controller: controller.doctorSpecialityController,
                        //     isReadOnly: true,
                        //     validator: (val) {
                        //       if (val!.trim().isEmpty) {
                        //         return "Please select doctorSpeciality.";
                        //       } else {
                        //         return null;
                        //       }
                        //     },
                        //     suffixIcon: Padding(
                        //       padding: const EdgeInsets.all(15.0),
                        //       child: SvgPicture.asset(
                        //         ConstAsset.down,
                        //         height: 20,
                        //         width: 20,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),

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
                          onTap: () {
                            controller.selectDegreeBottom();
                          },
                          isReadOnly: true,
                          controller: controller.degreeController,
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please select degree.";
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Select Degree',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: SvgPicture.asset(
                              ConstAsset.down,
                            ),
                          ),
                        ),
                        // CustomPopupMenu(
                        //   showArrow: false,
                        //   position: PreferredPosition.bottom,
                        //   menuBuilder: () => const DegreeList(),
                        //   pressType: PressType.singleClick,
                        //   verticalMargin: 5,
                        //   horizontalMargin: 20,
                        //   controller: controller.degreeNameController,
                        //   onTap: () {
                        //     controller.degreeNameController.showMenu();
                        //   },
                        //   child: AppTextField(
                        //     onTap: () {
                        //       controller.degreeNameController.showMenu();
                        //     },
                        //     hintText: 'Select Degree',
                        //     controller: controller.degreeController,
                        //     isReadOnly: true,
                        //     validator: (val) {
                        //       if (val!.trim().isEmpty) {
                        //         return "Please select degree.";
                        //       } else {
                        //         return null;
                        //       }
                        //     },
                        //     suffixIcon: Padding(
                        //       padding: const EdgeInsets.all(15.0),
                        //       child: SvgPicture.asset(
                        //         ConstAsset.down,
                        //         height: 20,
                        //         width: 20,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),

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
                          hintText: 'Enter Registration No',
                          keyboardType: TextInputType.number,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,

                          ],
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
                        // AppText(
                        //   text: 'Date Of Birth',
                        //   fontSize: Sizes.px14,
                        //   fontWeight: FontWeight.w600,
                        //   fontColor: ConstColor.black4B4D4F,
                        // ),
                        // SizedBox(
                        //   height: Sizes.crossLength * 0.010,
                        // ),
                        // CustomPopupMenu(
                        //   showArrow: false,
                        //   position: PreferredPosition.bottom,
                        //   menuBuilder: () => const SelectBirthDate(),
                        //   pressType: PressType.singleClick,
                        //   verticalMargin: 5,
                        //   horizontalMargin: 20,
                        //   controller: controller.selectDateController,
                        //   onTap: () {
                        //     controller.selectDateController.showMenu();
                        //   },
                        //   child: AppTextField(
                        //     hintText: 'Select Date',
                        //     controller: controller.dateOfOperation,
                        //     isReadOnly: true,
                        //     validator: (val) {
                        //       if (val!.trim().isEmpty) {
                        //         return "Please enter date of birth.";
                        //       } else {
                        //         return null;
                        //       }
                        //     },
                        //     onTap: () {
                        //       controller.selectDateController.showMenu();
                        //     },
                        //     suffixIcon: Padding(
                        //       padding: const EdgeInsets.all(12.0),
                        //       child: SvgPicture.asset(
                        //         ConstAsset.calender,
                        //         height: 20,
                        //         width: 20,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        AppText(
                          text: 'Date of Birth',
                          fontSize: Sizes.px15,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          hintText: 'Date of Birth',
                          controller: controller.dateOfOperation,
                          isReadOnly: true,
                          onTap: () {
                            previousDateEnable = true;
                            calenderType = 2;
                            controller.selectDateBirthBottomSheet();
                          },
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              ConstAsset.calender,
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
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
                      if (controller.profileForKey.currentState!
                          .validate()) {
                        controller.editProfile(context: context);
                      }
                    },
                    text: "Save",
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

