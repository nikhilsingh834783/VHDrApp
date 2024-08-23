import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_common_widgets/common_import.dart';
import '../controllers/no_internet_controller.dart';

class ServerErrorView extends GetView<NoInternetController> {
  const ServerErrorView({super.key});
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
                          // Icon(Icons.networ)
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
                                "It seems there's an issue with the server. Please try again later.",
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
                                controller.fetchData();
                                // controller.getConnectivityType();
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
