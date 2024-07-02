import 'package:flutter/material.dart';
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
        return Scaffold(
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
                onPressed: () => Navigator.pop(context)),
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
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Sizes.crossLength * 0.025,
                      ),
                      AppText(
                        text: 'IPD No',
                        fontSize: Sizes.px14,
                        fontWeight: FontWeight.w600,
                        fontColor: ConstColor.black4B4D4F,
                      ),
                      SizedBox(
                        height: Sizes.crossLength * 0.010,
                      ),
                      const AppTextField(
                        hintText: 'Enter IPD No.',
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
                      const AppTextField(
                        hintText: 'Enter Patient Name',
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
                      const AppTextField(
                        hintText: 'Enter Mobile Number',
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
                      const AppTextField(
                        hintText: 'Enter Surgeon Name',
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
                      const AppTextField(
                        hintText: 'Enter Schedule',
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
                      const AppTextField(
                        hintText: 'Enter UHID No',
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
                        children: [
                          Expanded(
                            child: AppTextField(
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
                        hintText: 'Select Organization',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
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
                      AppText(
                        text: 'Operation Name',
                        fontSize: Sizes.px14,
                        fontWeight: FontWeight.w600,
                        fontColor: ConstColor.black4B4D4F,
                      ),
                      SizedBox(
                        height: Sizes.crossLength * 0.010,
                      ),
                      const AppTextField(
                        hintText: 'Enter Operation Name',
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
                      const AppTextField(
                        hintText: 'Enter Operation Group',
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
                      const AppTextField(
                        hintText: 'Enter Operation Sub Group',
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
                      const AppTextField(
                        hintText: 'Enter Remarks',
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: Sizes.crossLength * 0.070,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: getDynamicHeight(size: 0.015)),
                child: SizedBox(
                  height: getDynamicHeight(size: 0.045),
                  width: getDynamicHeight(size: 0.170),
                  child: AppButton(
                    radius: 50,
                    onPressed: () {
                      print("=====");
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
