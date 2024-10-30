import 'package:get/get.dart';

import '../controllers/hospital_doctors_controller.dart';

class HospitalDoctorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalDoctorsController>(
      () => HospitalDoctorsController(),
    );
  }
}
