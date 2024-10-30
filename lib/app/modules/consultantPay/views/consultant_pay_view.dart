import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:venus/app/modules/consultantPay/views/consultant_graph_view.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../controllers/consultant_pay_controller.dart';
import 'pdf_constultan_view.dart';

class ConsultantPayView extends GetView<ConsultantPayController> {
  const ConsultantPayView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConsultantPayController());
    return GetBuilder<ConsultantPayController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: AppText(
              text: 'Consultant Pay',
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
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: FloatingActionButton(
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const ConsultantGraphView(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              shape: const CircleBorder(),
              backgroundColor: ConstColor.buttonColor,
              child: Image(
                image: AssetImage(ConstAsset.flotingGraph),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: Sizes.crossLength * 0.020,
              right: Sizes.crossLength * 0.020,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Sizes.crossLength * 0.03,
                ),
                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      onChanged: (newValue) {
                        controller.upDateSelectedItem(newValue.toString());
                        controller.getConsultantPay(selectedYear: newValue);
                        controller.update();
                      },
                      value: controller.selectedItem.value,
                      items: controller
                          .buildDropdownItems(controller.dropdownList),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: Sizes.crossLength * 0.15, // Adjusted height
                        decoration: BoxDecoration(
                          color: ConstColor.whiteColor,
                          borderRadius:
                              BorderRadius.circular(Sizes.crossLength * 0.010),
                          border: Border.all(
                            color: ConstColor.borderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                          color: ConstColor.whiteColor,
                          borderRadius:
                              BorderRadius.circular(Sizes.crossLength * 0.010),
                          border: Border.all(
                            color: ConstColor.borderColor,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.only(
                          right: Sizes.crossLength * 0.01,
                        ),
                      ),
                      hint: AppText(
                        text: 'Select Year',
                        fontSize: Sizes.px14,
                        fontColor: ConstColor.hintTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                      iconStyleData: IconStyleData(
                        icon: Image.asset(
                          ConstAsset.dropdown,
                          height: Sizes.crossLength * 0.017,
                          width: Sizes.crossLength * 0.021,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Sizes.crossLength * 0.02,
                ),
                Expanded(
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(bottom: hideBottomBar.value ? 25 : 65),
                    itemCount: controller.paymentStatus.length,
                    controller: controller.consultantScrollController,
                    itemBuilder: (context, index) {
                      Color statusColor =
                          controller.paymentStatus[index].pendingYN == 'N'
                              ? ConstColor.buttonColor
                              : ConstColor.blackA5A5A5;

                      return Padding(
                        padding:
                            EdgeInsets.only(top: getDynamicHeight(size: 0.015)),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              ConsultantPdfView(
                                header:
                                    controller.paymentStatus[index].monthYr ??
                                        '',
                                url: controller
                                        .paymentStatus[index].reportLinkURL ??
                                    '',
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ConstColor.whiteColor,
                              borderRadius:
                                  BorderRadiusDirectional.circular(10),
                              border: Border.all(
                                  width: 1, color: ConstColor.buttonColor),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getDynamicHeight(size: 0.010),
                                vertical: getDynamicHeight(size: 0.015),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: controller
                                                .paymentStatus[index].monthYr ??
                                            '',
                                        fontSize: Sizes.px14,
                                        fontWeight: FontWeight.w700,
                                        fontColor: ConstColor.black4B4D4F,
                                      ),
                                      AppText(
                                        text: 'Paid Amount',
                                        fontSize: Sizes.px12,
                                        fontWeight: FontWeight.w600,
                                        fontColor: ConstColor.buttonColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Sizes.crossLength * 0.008,
                                  ),
                                  controller.paymentStatus[index].pendingYN ==
                                          'N'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              text: 'Payment Successfully',
                                              fontSize: Sizes.px14,
                                              fontWeight: FontWeight.w600,
                                              fontColor: statusColor,
                                            ),
                                            AppText(
                                              text:
                                                  '₹. ${controller.paymentStatus[index].payment}',
                                              fontSize: Sizes.px12,
                                              fontWeight: FontWeight.w600,
                                              fontColor: ConstColor.buttonColor,
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                AppText(
                                                  text: 'Pending Amount: ',
                                                  fontSize: Sizes.px12,
                                                  fontWeight: FontWeight.w500,
                                                  fontColor: statusColor,
                                                ),
                                                AppText(
                                                  text: controller
                                                              .paymentStatus[
                                                                  index]
                                                              .pendingAmount !=
                                                          null
                                                      ? " ₹. ${controller.paymentStatus[index].pendingAmount.toString()}  "
                                                      : '',
                                                  fontSize: Sizes.px12,
                                                  fontWeight: FontWeight.w500,
                                                  fontColor: statusColor,
                                                ),
                                              ],
                                            ),
                                            AppText(
                                              text:
                                                  '₹. ${controller.paymentStatus[index].payment}',
                                              fontSize: Sizes.px12,
                                              fontWeight: FontWeight.w600,
                                              fontColor: ConstColor.buttonColor,
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
