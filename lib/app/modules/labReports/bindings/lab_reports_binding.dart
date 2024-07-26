import 'package:get/get.dart';

import '../controllers/lab_reports_controller.dart';

class LabReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabReportsController>(
      () => LabReportsController(),
    );
  }
}
