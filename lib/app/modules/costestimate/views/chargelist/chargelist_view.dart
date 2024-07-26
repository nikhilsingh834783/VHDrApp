import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_common_widgets/common_import.dart';
import '../../controllers/costestimate_controller.dart';
import 'widgets/charge_list_view_widget.dart';
import 'widgets/procedure_list_view_widget.dart';

class ChargelistView extends GetView<CostestimateController> {
  const ChargelistView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CostestimateController());
    return GetBuilder<CostestimateController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'Charges List',
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
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context);
                }),
          ),
          backgroundColor: Colors.white,
          // drawer: const MyDrawer(),
          body: Padding(
            padding: EdgeInsets.only(
              left: Sizes.crossLength * 0.020,
              right: Sizes.crossLength * 0.020,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizes.crossLength * 0.025,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: getDynamicHeight(size: 0.045),
                        child: AppButton(
                          radius: 45,
                          onPressed: () {
                            controller.selectedTab = 0;
                            controller.update();
                            controller.getChargeList();
                          },
                          text: "Charges List",
                          fontSize: Sizes.px14,
                          textColor: controller.selectedTab == 0
                              ? ConstColor.whiteColor
                              : ConstColor.black6B6B6B,
                          bgColor: controller.selectedTab == 0
                              ? ConstColor.buttonColor
                              : ConstColor.whiteF2F2F2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getDynamicHeight(size: 0.015),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: getDynamicHeight(size: 0.045),
                        child: AppButton(
                          radius: 45,
                          onPressed: () {
                            controller.selectedTab = 2;
                            controller.getProcedureList();
                            controller.update();
                          },
                          text: "Surgery/Producer List",
                          fontSize: Sizes.px14,
                          textColor: controller.selectedTab == 2
                              ? ConstColor.whiteColor
                              : ConstColor.black6B6B6B,
                          bgColor: controller.selectedTab == 2
                              ? ConstColor.buttonColor
                              : ConstColor.whiteF2F2F2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.010,
                ),
                Expanded(
                    child: controller.selectedTab == 0
                        ? const ChargeListWidget()
                        : const ProcedureListView()),
                SizedBox(
                  height: getDynamicHeight(size: 0.020),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
