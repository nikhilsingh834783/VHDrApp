import 'package:get/get.dart';

import '../controllers/patientlist_controller.dart';

class PatientlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientlistController>(
      () => PatientlistController(),
    );
  }
}
