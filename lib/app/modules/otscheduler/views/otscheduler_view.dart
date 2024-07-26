import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/otscheduler/views/widget/end_time_picker.dart';
import 'package:venus/app/modules/otscheduler/views/widget/operation_name.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/otscheduler_controller.dart';
import 'widget/custom_calendar.dart';
import 'widget/organization_name_list.dart';
import 'widget/start_time_picker.dart';

class OtschedulerView extends GetView<OtschedulerController> {
  const OtschedulerView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(OtschedulerController());
    return GetBuilder<OtschedulerController>(
      builder: (controller) {
        return Scaffold(
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
                          controller: controller.ipdTextController,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter IPD number.";
                            } else {
                              return null;
                            }
                          },
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
                        AppText(
                          text: 'Surgeon Name',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        AppTextField(
                          hintText: 'Enter Surgeon Name',
                          controller: controller.surgeonNameTextController,
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
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter schedule.";
                            } else {
                              return null;
                            }
                          },
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
                          controller: controller.uhidNumber,
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return "Please enter UHID number.";
                            } else {
                              return null;
                            }
                          },
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
                        CustomPopupMenu(
                          showArrow: false,
                          position: PreferredPosition.bottom,
                          menuBuilder: () => const SelectCustomDate(),
                          pressType: PressType.singleClick,
                          verticalMargin: 5,
                          horizontalMargin: 20,
                          controller: controller.selectDateController,
                          onTap: () {
                            controller.selectDateController.showMenu();
                          },
                          child: AppTextField(
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
                              controller.selectDateController.showMenu();
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
                              child: CustomPopupMenu(
                                showArrow: false,
                                position: PreferredPosition.bottom,
                                menuBuilder: () => const SelectStartTime(),
                                pressType: PressType.singleClick,
                                verticalMargin: 5,
                                horizontalMargin: 20,
                                controller: controller.startTimePicker,
                                onTap: () {
                                  controller.startTimePicker.showMenu();
                                },
                                child: AppTextField(
                                  onTap: () {
                                    controller.startTimePicker.showMenu();
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
                            ),
                            SizedBox(
                              width: Sizes.crossLength * 0.020,
                            ),
                            Expanded(
                              child: CustomPopupMenu(
                                showArrow: false,
                                position: PreferredPosition.bottom,
                                menuBuilder: () => const SelectEndTime(),
                                pressType: PressType.singleClick,
                                verticalMargin: 5,
                                horizontalMargin: 20,
                                controller: controller.endTimePicker,
                                onTap: () {
                                  controller.endTimePicker.showMenu();
                                },
                                child: AppTextField(
                                  onTap: () {
                                    controller.endTimePicker.showMenu();
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
                        CustomPopupMenu(
                          showArrow: false,
                          position: PreferredPosition.bottom,
                          menuBuilder: () => const OrganizationList(),
                          pressType: PressType.singleClick,
                          verticalMargin: 5,
                          horizontalMargin: 20,
                          controller: controller.organizationNameController,
                          onTap: () {
                            controller.organizationNameController.showMenu();
                          },
                          child: AppTextField(
                            onTap: () {
                              controller.organizationNameController.showMenu();
                            },
                            hintText: 'Select Organization',
                            controller: controller.organizationContoller,
                            isReadOnly: true,
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
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.025,
                        ),
                        AppText(
                          text: 'Operation Name',
                          fontSize: Sizes.px14,
                          fontWeight: FontWeight.w600,
                          fontColor: ConstColor.black4B4D4F,
                        ),
                        SizedBox(
                          height: Sizes.crossLength * 0.010,
                        ),
                        CustomPopupMenu(
                          showArrow: false,
                          position: PreferredPosition.bottom,
                          menuBuilder: () => const OperationListView(),
                          pressType: PressType.singleClick,
                          verticalMargin: 5,
                          horizontalMargin: 20,
                          controller: controller.operationNamePopupController,
                          onTap: () {
                            controller.operationNamePopupController.showMenu();
                          },
                          child: AppTextField(
                            isReadOnly: true,
                            onTap: () {
                              controller.operationNamePopupController
                                  .showMenu();
                            },
                            hintText: 'Enter Operation Name',
                            controller: controller.operationNameController,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please enter operation name.";
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
                        ),
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
                padding: EdgeInsets.only(bottom: getDynamicHeight(size: 0.015)),
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
        );
      },
    );
  }
}
