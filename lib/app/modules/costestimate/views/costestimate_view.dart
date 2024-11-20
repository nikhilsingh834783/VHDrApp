import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/costestimate_controller.dart';
import 'chargelist/chargelist_view.dart';
import 'widgets/gender_list.dart';
import 'widgets/high_risk_type.dart';

class CostestimateView extends GetView<CostestimateController> {
  const CostestimateView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CostestimateController());
    return GetBuilder<CostestimateController>(
      builder: (controller) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            // This can be async and you can check your condition
            if (controller.fromSurgeryScreen) {
              Navigator.pop(context);
            } else {
              backButtonPress();
            }
          },
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: AppText(
                text: 'Surgical Estimate',
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
                  onPressed: () => controller.fromSurgeryScreen
                      ? Navigator.pop(context)
                      : backButtonPress()),
            ),
            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: false,
            // drawer: const MyDrawer(),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.crossLength * 0.020,
                      right: Sizes.crossLength * 0.020,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: controller.estimateFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Sizes.crossLength * 0.025,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: 'Patient Name ',
                                fontSize: Sizes.px15,
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
                            hintText: 'Enter Patient Name',
                            controller: controller.patientNameController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter patient name.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Age',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Your Age',
                            controller: controller.ageController,
                            keyboardType: TextInputType.number,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter age.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Gender',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          CustomPopupMenu(
                            showArrow: false,
                            position: PreferredPosition.bottom,
                            menuBuilder: () => const GenderListView(),
                            pressType: PressType.singleClick,
                            verticalMargin: 5,
                            horizontalMargin: 20,
                            controller: controller.genderPopupMenuController,
                            onTap: () {
                              controller.genderPopupMenuController.showMenu();
                            },
                            child: AppTextField(
                              onTap: () {
                                controller.genderPopupMenuController.showMenu();
                              },
                              hintText: 'Select Gender',
                              controller: controller.genderController,
                              isReadOnly: true,
                              // validator: (val) {
                              //   if (val!.trim().isEmpty) {
                              //     return "Please select gender.";
                              //   } else {
                              //     return null;
                              //   }
                              // },
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
                          // DropdownButtonFormField2(
                          //   dropdownStyleData: DropdownStyleData(
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10))),
                          //   iconStyleData: IconStyleData(
                          //     icon: SvgPicture.asset(
                          //       ConstAsset.down,
                          //     ),
                          //   ),
                          //   style: commonTextStyle(),
                          //   validator: (value) =>
                          //       value == null ? 'field required' : null,
                          //   items: controller.genderList
                          //       .map((cityTitle) => DropdownMenuItem(
                          //           value: cityTitle, child: Text(cityTitle)))
                          //       .toList(),
                          //   onChanged: (va) {
                          //     controller.selectedGender = va;
                          //     controller.update();
                          //   },
                          //   value: controller.selectedGender,
                          //   decoration:
                          //       dropDownDecoration(hintText: "Select Gender"),
                          // ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Organization Name',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            onTap: () {
                              controller.searchOrganizationListData = null;
                              controller.selectOrganizationBottomSheet();
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
                            height: Sizes.crossLength * 0.020,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: 'Consultant/surgeon Doctor ',
                                fontSize: Sizes.px15,
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
                            hintText: 'Dr. Ram Manohar Lohia',
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onTap: () {
                              controller.searchAdditionalDoctorList = null;
                              controller.selectSurgeonBottom(context: context);
                            },
                            isReadOnly: true,
                            controller: controller.consultantController,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                ConstAsset.down,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please enter surgeon name.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Specialty',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            isReadOnly: true,
                            hintText: 'Dentist',
                            controller: controller.specialityController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter speciliaty.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: 'Room Type ',
                                fontSize: Sizes.px15,
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
                            onTap: () {
                              controller.selectRoomBottom();
                            },
                            isReadOnly: true,
                            controller: controller.roomTypeController,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please select room.";
                              } else {
                                return null;
                              }
                            },
                            hintText: 'Select Room Type',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                ConstAsset.down,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: 'Stay Days ',
                                fontSize: Sizes.px15,
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
                            onTap: () {
                              controller.selectDaysBottom();
                            },
                            isReadOnly: true,
                            hintText: 'Select Stay Days',
                            controller: controller.stayDayController,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please select numbers of days.";
                              } else {
                                return null;
                              }
                            },
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                ConstAsset.down,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Surgery/Procedure',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          controller.selectedOperationList.isEmpty
                              ? AppTextField(
                                  isReadOnly: true,
                                  onTap: () {
                                    controller.searchOperationNameListData =
                                        null;
                                    controller.selectOperationName();
                                  },
                                  hintText: 'Select Surgery/Procedure',
                                  controller: controller.procedureController,
                                  validator: (val) {
                                    if (val!.trim().isEmpty) {
                                      return "Please select procedure.";
                                    } else {
                                      return null;
                                    }
                                  },
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      ConstAsset.down,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    controller.searchOperationNameListData =
                                        null;
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
                                          left: 10,
                                          right: 10,
                                          top: 15,
                                          bottom: 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Wrap(
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
                                                                      .id);
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
                          //     showArrow: false,
                          //     position: PreferredPosition.bottom,
                          //     menuBuilder: () => const ProcedureListView(),
                          //     pressType: PressType.singleClick,
                          //     verticalMargin: 5,
                          //     horizontalMargin: 20,
                          //     controller: controller.procedurePopMenuController,
                          //     onTap: () {
                          //       controller.procedurePopMenuController.showMenu();
                          //     },
                          //     child: Container(
                          //       height: 48,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Colors.white,
                          //         border: Border.all(
                          //           width: 1,
                          //           color: ConstColor.borderColor,
                          //         ),
                          //       ),
                          //       child: Center(
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 10, right: 10),
                          //           child: Row(
                          //             children: [
                          //               Expanded(
                          //                   child: controller
                          //                           .selectedOperationList.isEmpty
                          //                       ? AppText(
                          //                           text:
                          //                               'Select Surgery/Procedure',
                          //                           fontColor:
                          //                               ConstColor.hintTextColor,
                          //                         )
                          //                       : ListView.builder(
                          //                           itemCount: controller
                          //                               .selectedOperationList
                          //                               .length,
                          //                           scrollDirection:
                          //                               Axis.horizontal,
                          //                           shrinkWrap: true,
                          //                           itemBuilder: (item, index) {
                          //                             return Padding(
                          //                               padding:
                          //                                   const EdgeInsets.only(
                          //                                       top: 7,
                          //                                       bottom: 7,
                          //                                       right: 10),
                          //                               child: Container(
                          //                                 width: 80,
                          //                                 height: 20,
                          //                                 decoration: BoxDecoration(
                          //                                     boxShadow: const [
                          //                                       BoxShadow(
                          //                                         color:
                          //                                             Colors.grey,
                          //                                         blurRadius: 2.0,
                          //                                       ),
                          //                                     ],
                          //                                     borderRadius:
                          //                                         BorderRadius
                          //                                             .circular(
                          //                                                 10),
                          //                                     color:
                          //                                         Colors.white),
                          //                                 child: Padding(
                          //                                   padding:
                          //                                       const EdgeInsets
                          //                                           .only(
                          //                                           left: 7,
                          //                                           right: 5),
                          //                                   child: Row(
                          //                                     children: [
                          //                                       Expanded(
                          //                                         child: AppText(
                          //                                           text: controller
                          //                                                   .selectedOperationList[
                          //                                                       index]
                          //                                                   .operationName ??
                          //                                               '',
                          //                                           maxLine: 1,
                          //                                           overflow:
                          //                                               TextOverflow
                          //                                                   .ellipsis,
                          //                                         ),
                          //                                       ),
                          //                                       GestureDetector(
                          //                                           onTap: () {
                          //                                             FocusScope.of(
                          //                                                     context)
                          //                                                 .unfocus();
                          //                                             controller
                          //                                                 .selectedOperationId
                          //                                                 .remove(controller
                          //                                                     .selectedOperationList[index]
                          //                                                     .id);
                          //                                             controller
                          //                                                 .selectedOperationList
                          //                                                 .remove(
                          //                                                     controller.selectedOperationList[index]);
                          //                                             controller
                          //                                                 .update();
                          //                                           },
                          //                                           child:
                          //                                               const Icon(
                          //                                             Icons
                          //                                                 .cancel_outlined,
                          //                                             size: 20,
                          //                                             color: ConstColor
                          //                                                 .errorBorderColor,
                          //                                           ))
                          //                                     ],
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             );
                          //                           })),
                          //               SvgPicture.asset(
                          //                 ConstAsset.down,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     )

                          // ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Date of Surgery/Procedure',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Select Operation Date',
                            controller: controller.dateController,
                            isReadOnly: true,
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter operation date.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
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
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Time of Surgery/Procedure',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),

                          AppTextField(
                            onTap: () {
                              controller.selectTimeBottomSheet();
                            },
                            isReadOnly: true,
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please select time.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            controller: controller.timeController,
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
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Additional surgeon Doctor',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            onTap: () {
                              controller.searchAdditionalDoctorList = null;
                              controller.showAdditionalSurgeon(
                                  context: context);
                            },
                            isReadOnly: true,
                            hintText: 'Select Additional surgeon Doctor',
                            controller: controller.additionSurgeonController,
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please select additional surgeon doctor.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            suffixIcon: controller
                                    .additionSurgeonController.text
                                    .trim()
                                    .isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      controller.additionSurgeonController
                                          .clear();
                                    },
                                    child: const Icon(Icons.cancel_outlined))
                                : Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: SvgPicture.asset(
                                      ConstAsset.down,
                                    ),
                                  ),
                          ),
                          // CustomPopupMenu(
                          //   showArrow: false,
                          //   position: PreferredPosition.top,
                          //   menuBuilder: () => Padding(
                          //     padding: EdgeInsets.only(
                          //         bottom:
                          //             MediaQuery.of(context).viewInsets.bottom),
                          //     child: const AdditionalSurgeonListView(),
                          //   ),
                          //   pressType: PressType.singleClick,
                          //   verticalMargin: 5,
                          //   horizontalMargin: 20,
                          //   controller: controller.additionalSurgeonController,
                          //   onTap: () {
                          //     controller.additionalSurgeonController.showMenu();
                          //     controller.searchAdditionalDoctorList = null;
                          //   },
                          //   child: AppTextField(
                          //     onTap: () {
                          //       controller.additionalSurgeonController.showMenu();
                          //       controller.searchAdditionalDoctorList = null;
                          //     },
                          //     isReadOnly: true,
                          //     hintText: 'Select Additional surgeon Doctor',
                          //     controller: controller.additionSurgeonController,
                          //     validator: (val) {
                          //       if (val!.trim().isEmpty) {
                          //         return "Please select additional surgeon doctor.";
                          //       } else {
                          //         return null;
                          //       }
                          //     },
                          //     suffixIcon: Padding(
                          //       padding: const EdgeInsets.all(14.0),
                          //       child: SvgPicture.asset(
                          //         ConstAsset.down,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: 'High Risk ',
                                fontSize: Sizes.px15,
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
                          CustomPopupMenu(
                            showArrow: false,
                            position: PreferredPosition.bottom,
                            menuBuilder: () => const HighRiskView(),
                            pressType: PressType.singleClick,
                            verticalMargin: 5,
                            horizontalMargin: 20,
                            controller: controller.highRiskPopController,
                            onTap: () {
                              controller.highRiskPopController.showMenu();
                            },
                            child: AppTextField(
                              onTap: () {
                                controller.highRiskPopController.showMenu();
                              },
                              hintText: 'Select High Risk Type',
                              controller: controller.highRiskController,
                              isReadOnly: true,
                              validator: (val) {
                                if (val!.trim().isEmpty) {
                                  return "Please select risk type.";
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
                          // DropdownButtonFormField2(
                          //   dropdownStyleData: DropdownStyleData(
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10))),
                          //   iconStyleData: IconStyleData(
                          //     icon: SvgPicture.asset(
                          //       ConstAsset.down,
                          //     ),
                          //   ),
                          //   style: commonTextStyle(),
                          //   items: controller.highRiskList
                          //       .map((cityTitle) => DropdownMenuItem(
                          //           value: cityTitle, child: Text(cityTitle)))
                          //       .toList(),
                          //   onChanged: (va) {
                          //     controller.selectedHighRisk = va;
                          //     controller.update();
                          //   },
                          //   value: controller.selectedHighRisk,
                          //   decoration: dropDownDecoration(
                          //       hintText: "Select High Risk Type"),
                          // ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Consumables',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            controller: controller.consumableController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            keyboardType: TextInputType.number,
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter consumable.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            hintText: 'Enter Consumables',
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Implants',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Implants',
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            keyboardType: TextInputType.number,
                            controller: controller.implantcontroller,
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter implants.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Other Expense',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: 'Enter Other Expense',
                            keyboardType: TextInputType.number,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            controller: controller.otherExpenseController,
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter other expense.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          AppText(
                            text: 'Consultant Visit Charges',
                            fontSize: Sizes.px15,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.black4B4D4F,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.010,
                          ),
                          AppTextField(
                            hintText: '',
                            keyboardType: TextInputType.number,
                            controller: controller.visitChargeController,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            // validator: (val) {
                            //   if (val!.trim().isEmpty) {
                            //     return "Please enter consultant visit charge.";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.020,
                          ),
                          // AppText(
                          //   text: 'Total Estimate',
                          //   fontSize: Sizes.px15,
                          //   fontWeight: FontWeight.w600,
                          //   fontColor: ConstColor.black4B4D4F,
                          // ),
                          // SizedBox(
                          //   height: Sizes.crossLength * 0.010,
                          // ),
                          // AppTextField(
                          //   hintText: 'Enter Total Estimate',
                          //   keyboardType: TextInputType.number,
                          //   controller: controller.totalEstimateController,
                          //   onTapOutside: (event) {
                          //     FocusScope.of(context).unfocus();
                          //   },
                          //   textInputAction: TextInputAction.done,
                          //   // validator: (val) {
                          //   //   if (val!.trim().isEmpty) {
                          //   //     return "Please enter total estimate.";
                          //   //   } else {
                          //   //     return null;
                          //   //   }
                          //   // },
                          // ),
                          SizedBox(
                            height: Sizes.crossLength * 0.070,
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
                              FocusScope.of(context).unfocus();
                              if (controller.estimateFormKey.currentState!
                                  .validate()) {
                                controller.selectedTab = 0;
                                controller.getChargeList();
                                Get.to(const ChargelistView())!.then((value) =>
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus());
                              }
                            },
                            text: "Get Total",
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
