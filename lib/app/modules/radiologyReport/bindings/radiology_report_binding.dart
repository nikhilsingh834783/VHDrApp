import 'package:get/get.dart';

import '../controllers/radiology_report_controller.dart';

class RadiologyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RadiologyReportController>(
      () => RadiologyReportController(),
    );
  }
}
