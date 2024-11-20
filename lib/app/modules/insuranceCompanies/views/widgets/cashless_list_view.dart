import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/insurance_companies_controller.dart';

class CashlessListView extends StatelessWidget {
  const CashlessListView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InsuranceCompaniesController());

    return GetBuilder<InsuranceCompaniesController>(builder: (controller) {
      return controller.cashLessList.isEmpty
          ? Center(
              child: AppText(
                text: "No data found.",
                fontSize: Sizes.px15,
                fontWeight: FontWeight.w600,
              ),
            )
          : ListView.builder(
              itemCount: controller.cashLessList.length,
              padding: const EdgeInsets.only(bottom: 20),
              controller: controller.cashlessScrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: getDynamicHeight(size: 0.01)),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ConstColor.whiteColor,
                      border: Border.all(
                        color: ConstColor.buttonColor.withOpacity(0.4),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.crossLength * 0.016,
                          vertical: Sizes.crossLength * 0.008),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Sizes.crossLength * 0.0045),
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  text:
                                      'TPA Name: ${controller.cashLessList[index].name}',
                                  fontSize: Sizes.px14,
                                  fontColor: ConstColor.black4B4D4F,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.crossLength * 0.0045),
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
