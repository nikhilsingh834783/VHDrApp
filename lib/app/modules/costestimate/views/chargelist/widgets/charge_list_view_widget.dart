import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/costestimate/controllers/costestimate_controller.dart';

import '../../../../../app_common_widgets/common_import.dart';

class ChargeListWidget extends StatelessWidget {
  const ChargeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
      return controller.chargeListData.isEmpty
          ? Center(
              child: AppText(
                text: 'No data found',
                fontSize: Sizes.px15,
                fontWeight: FontWeight.w600,
              ),
            )
          : ListView.builder(
              itemCount: controller.chargeListData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: getDynamicHeight(size: 0.015)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ConstColor.whiteColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                          ),
                        ],
                        borderRadius: BorderRadiusDirectional.circular(10),
                        border: Border.all(
                            width: 1,
                            color: ConstColor.buttonColor.withOpacity(0.4))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getDynamicHeight(size: 0.010),
                        vertical: getDynamicHeight(size: 0.015),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text:
                                'Room Type: ${controller.chargeListData[index].roomtype}',
                            fontSize: Sizes.px14,
                            fontWeight: FontWeight.w600,
                            fontColor: ConstColor.buttonColor,
                          ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.015),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  AppText(
                                    text: 'Surgery/Producer Charges',
                                    fontSize: Sizes.px12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ConstColor.black6B6B6B,
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(size: 0.005),
                                  ),
                                  AppText(
                                    text:
                                        '(Surgeon + Anaesthetist + OT Charges)',
                                    fontSize: Sizes.px9,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ConstColor.black6B6B6B,
                                  )
                                ],
                              ),
                              AppText(
                                text:
                                    '₹  ${controller.chargeListData[index].surgeryProcCharg}',
                                fontSize: Sizes.px12,
                                fontWeight: FontWeight.w500,
                                fontColor: ConstColor.black6B6B6B,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.015),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          'Surgery/Producer/Hospitalisation Expense',
                                      fontSize: Sizes.px12,
                                      fontWeight: FontWeight.w500,
                                      fontColor: ConstColor.black6B6B6B,
                                      maxLine: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: getDynamicHeight(size: 0.005),
                                    ),
                                    AppText(
                                      text:
                                          'Additional Surgeon + Emergency + High Risk)',
                                      fontSize: Sizes.px9,
                                      fontWeight: FontWeight.w500,
                                      fontColor: ConstColor.black6B6B6B,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getDynamicHeight(size: 0.010),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text:
                                        ' ${controller.chargeListData[index].surgProcHospExpTotal}',
                                    fontSize: Sizes.px12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ConstColor.black6B6B6B,
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(size: 0.005),
                                  ),
                                  AppText(
                                    text:
                                        'ER: ₹.  ${controller.chargeListData[index].surgProcHospExpEmerg}',
                                    fontSize: Sizes.px12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ConstColor.black6B6B6B,
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    height: getDynamicHeight(size: 0.005),
                                  ),
                                  AppText(
                                    text:
                                        'HR: ₹.  ${controller.chargeListData[index].surgProcHospExpHighRsk}',
                                    fontSize: Sizes.px12,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ConstColor.black6B6B6B,
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.020),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: 'Indoor Charges',
                                      fontSize: Sizes.px12,
                                      fontWeight: FontWeight.w500,
                                      fontColor: ConstColor.black6B6B6B,
                                      maxLine: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: getDynamicHeight(size: 0.005),
                                    ),
                                    AppText(
                                      text: '(Room + Doctor Visit Charges)',
                                      fontSize: Sizes.px9,
                                      fontWeight: FontWeight.w500,
                                      fontColor: ConstColor.black6B6B6B,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getDynamicHeight(size: 0.010),
                              ),
                              AppText(
                                text:
                                    '₹.  ${controller.chargeListData[index].indoorCharges}',
                                fontSize: Sizes.px12,
                                fontWeight: FontWeight.w500,
                                fontColor: ConstColor.black6B6B6B,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.015),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppText(
                                  text: 'Consumables',
                                  fontSize: Sizes.px12,
                                  fontWeight: FontWeight.w500,
                                  fontColor: ConstColor.black6B6B6B,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              AppText(
                                text:
                                    '₹.  ${controller.chargeListData[index].consumables}',
                                fontSize: Sizes.px12,
                                fontWeight: FontWeight.w500,
                                fontColor: ConstColor.black6B6B6B,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.010),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppText(
                                  text: 'Implants',
                                  fontSize: Sizes.px12,
                                  fontWeight: FontWeight.w500,
                                  fontColor: ConstColor.black6B6B6B,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              AppText(
                                text:
                                    '₹.  ${controller.chargeListData[index].implants}',
                                fontSize: Sizes.px12,
                                fontWeight: FontWeight.w500,
                                fontColor: ConstColor.black6B6B6B,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.010),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppText(
                                  text: 'Other Expense',
                                  fontSize: Sizes.px12,
                                  fontWeight: FontWeight.w500,
                                  fontColor: ConstColor.black6B6B6B,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              AppText(
                                text:
                                    '₹.  ${controller.chargeListData[index].otherExp}',
                                fontSize: Sizes.px12,
                                fontWeight: FontWeight.w500,
                                fontColor: ConstColor.black6B6B6B,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: getDynamicHeight(size: 0.010),
                          // ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       child: AppText(
                          //         text: 'Special Dr. Visit',
                          //         fontSize: Sizes.px12,
                          //         fontWeight: FontWeight.w500,
                          //         fontColor: ConstColor.black6B6B6B,
                          //         maxLine: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //       ),
                          //     ),
                          //     AppText(
                          //       text: '₹. 3,000',
                          //       fontSize: Sizes.px12,
                          //       fontWeight: FontWeight.w500,
                          //       fontColor: ConstColor.black6B6B6B,
                          //       maxLine: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: getDynamicHeight(size: 0.010),
                          // ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Expanded(
                          //       child: AppText(
                          //         text: 'Super Special Dr. Visit',
                          //         fontSize: Sizes.px12,
                          //         fontWeight: FontWeight.w500,
                          //         fontColor: ConstColor.black6B6B6B,
                          //         maxLine: 1,
                          //         overflow: TextOverflow.ellipsis,
                          //       ),
                          //     ),
                          //     AppText(
                          //       text: '₹. 4,800',
                          //       fontSize: Sizes.px12,
                          //       fontWeight: FontWeight.w500,
                          //       fontColor: ConstColor.black6B6B6B,
                          //       maxLine: 1,
                          //       overflow: TextOverflow.ellipsis,
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.010),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: AppText(
                                  text: 'Total',
                                  fontSize: Sizes.px12,
                                  fontWeight: FontWeight.w500,
                                  fontColor: ConstColor.black6B6B6B,
                                  maxLine: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              AppText(
                                text:
                                    '₹.  ${controller.chargeListData[index].total}',
                                fontSize: Sizes.px12,
                                fontWeight: FontWeight.w500,
                                fontColor: ConstColor.black6B6B6B,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    });
  }
}
