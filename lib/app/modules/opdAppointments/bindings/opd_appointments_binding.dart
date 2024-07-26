import 'package:get/get.dart';

import '../controllers/opd_appointments_controller.dart';

class OpdAppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpdAppointmentsController>(
      () => OpdAppointmentsController(),
    );
  }
}
