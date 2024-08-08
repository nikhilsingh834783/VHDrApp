import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/no_internet_controller.dart';

class NoInternetView extends GetView<NoInternetController> {
  const NoInternetView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(NoInternetController());
    Sizes.init(context);
    return GetBuilder(
      builder: (NoInternetController controller) {
        return Scaffold(
          backgroundColor: ConstColor.whiteColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/png/notinternet.png",
                            height: 113,
                            width: 256,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.030,
                          ),
                          AppText(
                            text: "Oops!",
                            textAlign: TextAlign.center,
                            fontSize: Sizes.px25,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.030,
                          ),
                          AppText(
                            text:
                                "There is no internet connection please check your internet connection.",
                            textAlign: TextAlign.center,
                            fontSize: Sizes.px18,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: Sizes.crossLength * 0.035,
                          ),
                          Center(
                            child: AppButton(
                              radius: 50,
                              textColor: ConstColor.whiteColor,
                              text: "Try Again",
                              onPressed: () {
                                controller.getConnectivityType();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
