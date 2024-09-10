import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/otscheduler_controller.dart';

class OtschedulerView extends GetView<OtschedulerController> {
  const OtschedulerView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OtschedulerController());
    return GetBuilder<OtschedulerController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            controller.getbackFunction(context: context);
            return Future.value(true);
          },
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: AppText(
                text: 'OT Scheduler Entry',
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
                  onPressed: () {
                    controller.getbackFunction(context: context);
                  }),
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
                    key: controller.otSchduleForKey,
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
                          AppText(
                            text: 'IPD NO',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter IPD No.',
                            enabled: false,
                            fillColor: ConstColor.greyF3F3F3,
                            isReadOnly: true,
                            controller: controller.ipdTextController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter IPD number.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'Patient Name',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Patient Name',
                            controller: controller.patientName,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please enter patient name.";
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
                              AppText(
                                text: 'Mobile Number ',
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w600,
                                fontColor: ConstColor.black4B4D4F,
                              ),
                              AppText(
                                text: '*',
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w600,
                                fontColor: ConstColor.redColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            controller: controller.mobileController,
                            hintText: 'Enter Mobile Number',
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
                          Row(
                            children: [
                              AppText(
                                text: 'Surgeon Name ',
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w600,
                                fontColor: ConstColor.black4B4D4F,
                              ),
                              AppText(
                                text: '*',
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w600,
                                fontColor: ConstColor.redColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Surgeon Name',
                            controller: controller.surgeonNameTextController,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                ConstAsset.down,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            isReadOnly: true,
                            onTap: () {
                              controller.searchAdditionalDoctorList = null;
                              controller.showAdditionalSurgeon(
                                  context: context);
                            },
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please enter surgeon name.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'Schedule By',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Schedule',
                            controller: controller.schduleByController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter schedule.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'UHID No',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter UHID No',
                            enabled: false,
                            fillColor: ConstColor.greyF3F3F3,
                            isReadOnly: true,
                            controller: controller.uhidNumber,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter UHID number.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'Date Of Operation',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Select Operation Date',
                            controller: controller.dateOfOperation,
                            isReadOnly: true,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please enter operation date.";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              controller.selectDateBottomSheet();
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
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  text: 'OT Start Time',
                                  fontSize: Sizes.px14,
                                  fontWeight: FontWeight.w600,
                                  fontColor: ConstColor.black4B4D4F,
                                ),
                              ),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppText(
                                  text: 'OT End Time',
                                  fontSize: Sizes.px14,
                                  fontWeight: FontWeight.w600,
                                  fontColor: ConstColor.black4B4D4F,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AppTextField(
                                  onTap: () {
                                    controller.selectStartTimeBottomSheet();
                                  },
                                  isReadOnly: true,
                                  validator: (val) {
                                    if (val!.trim().isEmpty) {
                                      return "Please enter start time.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: controller.startTimeController,
                                  hintText: 'Start Time',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      ConstAsset.time,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Sizes.crossLength * 0.020,
                              ),
                              Expanded(
                                child: AppTextField(
                                  onTap: () {
                                    controller.selectEndTimeBottomSheet();
                                  },
                                  isReadOnly: true,
                                  controller: controller.endTimeController,
                                  validator: (val) {
                                    if (val!.trim().isEmpty) {
                                      return "Please enter end time.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hintText: 'End Time',
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      ConstAsset.time,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'Organization Name',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            onTap: () {
                              // controller.searchOrganizationListData = null;
                              // controller.selectOrganizationBottomSheet();
                            },
                            hintText: 'Select Organization',
                            enabled: false,
                            fillColor: ConstColor.greyF3F3F3,
                            isReadOnly: true,
                            controller: controller.organizationContoller,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please select organization.";
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                ConstAsset.down,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: 'Operation Name ',
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w600,
                                fontColor: ConstColor.black4B4D4F,
                              ),
                              AppText(
                                text: '*',
                                fontSize: Sizes.px14,
                                fontWeight: FontWeight.w600,
                                fontColor: ConstColor.redColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),

                          GestureDetector(
                            onTap: () {
                              controller.searchOperationNameListData = null;
                              controller.selectOperationName();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: ConstColor.borderColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15, bottom: 15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: controller
                                              .selectedOperationList.isEmpty
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: AppText(
                                                    text: 'Select Surgery',
                                                    fontColor: ConstColor
                                                        .hintTextColor,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  ConstAsset.down,
                                                  height: 20,
                                                  width: 20,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            )
                                          : Wrap(
                                              runSpacing: 5,
                                              spacing: 8,
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        controller
                                                            .selectedOperationList
                                                            .length;
                                                    i++)
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: ConstColor
                                                                .hintTextColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 7,
                                                              right: 5,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Flexible(
                                                            child: AppText(
                                                              text: controller
                                                                      .selectedOperationList[
                                                                          i]
                                                                      .operationName ??
                                                                  '',
                                                              maxLine: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              controller
                                                                  .selectedOperationId
                                                                  .remove(controller
                                                                      .selectedOperationList[
                                                                          i]
                                                                      .id
                                                                      .toString());
                                                              controller
                                                                  .selectedOperationList
                                                                  .remove(controller
                                                                      .selectedOperationList[i]);
                                                              controller
                                                                  .update();
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              size: 20,
                                                              color: ConstColor
                                                                  .errorBorderColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // CustomPopupMenu(
                          //   showArrow: false,
                          //   position: PreferredPosition.bottom,
                          //   menuBuilder: () => const OperationListView(),
                          //   pressType: PressType.singleClick,
                          //   verticalMargin: 5,
                          //   horizontalMargin: 20,
                          //   controller: controller.operationNamePopupController,
                          //   onTap: () {
                          //     controller.operationNamePopupController.showMenu();
                          //   },
                          //   child: AppTextField(
                          //     isReadOnly: true,
                          //     onTap: () {
                          //       controller.operationNamePopupController
                          //           .showMenu();
                          //     },
                          //     hintText: 'Enter Operation Name',
                          //     controller: controller.operationNameController,
                          //     validator: (val) {
                          //       if (val!.trim().isEmpty) {
                          //         return "Please enter operation name.";
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
                            text: 'Operation Group',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Operation Group',
                            controller: controller.operationGroup,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter operation group.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'Operation Sub Group',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Operation Sub Group',
                            controller: controller.operationSubGroupController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter operation sub group.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          AppText(
                            text: 'Remarks',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Remarks',
                            controller: controller.remarksController,
                            textInputAction: TextInputAction.done,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.080,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: getDynamicHeight(size: 0.015)),
                  child: MediaQuery.of(context).viewInsets.bottom != 0
                      ? const SizedBox()
                      : SizedBox(
                          height: getDynamicHeight(size: 0.045),
                          width: getDynamicHeight(size: 0.170),
                          child: AppButton(
                            radius: 50,
                            onPressed: () {
                              if (controller.otSchduleForKey.currentState!
                                  .validate()) {
                                controller.createOtSchdule(context: context);
                              }
                            },
                            text: "Submit",
                          ),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
