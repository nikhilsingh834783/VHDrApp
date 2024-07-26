import 'package:get/get.dart';

import '../controllers/progress_summary_controller.dart';

class ProgressSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressSummaryController>(
      () => ProgressSummaryController(),
    );
  }
}
