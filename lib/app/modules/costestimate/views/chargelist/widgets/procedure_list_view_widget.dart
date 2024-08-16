import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/costestimate/controllers/costestimate_controller.dart';

import '../../../../../app_common_widgets/common_import.dart';

class ProcedureListView extends StatelessWidget {
  const ProcedureListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CostestimateController>(builder: (controller) {
      return controller.procedureListAllData.isEmpty
          ? Center(
              child: AppText(
                text: 'No data found',
                fontSize: Sizes.px15,
                fontWeight: FontWeight.w600,
              ),
            )
          : ListView.builder(
              itemCount: controller.procedureListAllData.length,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AppText(
                                  text:
                                      'Surgery/Procedure: ${controller.procedureListAllData[index].testName} ',
                                  fontSize: Sizes.px14,
                                  fontWeight: FontWeight.w600,
                                  fontColor: ConstColor.buttonColor,
                                  overflow: TextOverflow.ellipsis,
                                  maxLine: 2,
                                ),
                              ),
                              AppText(
                                text:
                                    '₹  ${controller.procedureListAllData[index].testRate}',
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
                            children: [
                              SvgPicture.asset(ConstAsset.threePersons),
                              SizedBox(
                                width: getDynamicHeight(size: 0.010),
                              ),
                              Expanded(
                                child: AppText(
                                  text:
                                      '${controller.procedureListAllData[index].operationName}',
                                  fontSize: Sizes.px12,
                                  fontWeight: FontWeight.w500,
                                  fontColor: ConstColor.black6B6B6B,
                                  maxLine: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: getDynamicHeight(size: 0.015),
                          // ),
                          // Row(
                          //   children: [
                          //     SvgPicture.asset(ConstAsset.groupPersons),
                          //     SizedBox(
                          //       width: getDynamicHeight(size: 0.010),
                          //     ),
                          //     AppText(
                          //       text: 'Arthroscopic Surgery',
                          //       fontSize: Sizes.px12,
                          //       fontWeight: FontWeight.w500,
                          //       fontColor: ConstColor.black6B6B6B,
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: getDynamicHeight(size: 0.015),
                          ),
                          // Row(
                          //   children: [
                          //     SvgPicture.asset(ConstAsset.otCharges),
                          //     SizedBox(
                          //       width: getDynamicHeight(size: 0.010),
                          //     ),
                          //     AppText(
                          //       text: 'Arthroscopic Surgery - L OT Charges',
                          //       fontSize: Sizes.px12,
                          //       fontWeight: FontWeight.w500,
                          //       fontColor: ConstColor.black6B6B6B,
                          //     ),
                          //   ],
                          // ),
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
