import 'package:get/get.dart';

import '../controllers/otscheduler_controller.dart';

class OtschedulerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtschedulerController>(
      () => OtschedulerController(),
    );
  }
}
