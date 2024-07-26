import 'package:get/get.dart';

import '../controllers/schedulechargelist_controller.dart';

class SchedulechargelistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulechargelistController>(
      () => SchedulechargelistController(),
    );
  }
}
