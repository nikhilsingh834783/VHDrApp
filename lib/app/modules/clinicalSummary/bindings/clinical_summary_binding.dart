import 'package:get/get.dart';

import '../controllers/clinical_summary_controller.dart';

class ClinicalSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClinicalSummaryController>(
      () => ClinicalSummaryController(),
    );
  }
}
