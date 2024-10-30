import 'package:get/get.dart';

import '../controllers/consultant_pay_controller.dart';

class ConsultantPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConsultantPayController>(
      () => ConsultantPayController(),
    );
  }
}
