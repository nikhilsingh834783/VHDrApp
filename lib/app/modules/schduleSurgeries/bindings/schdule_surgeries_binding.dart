import 'package:get/get.dart';

import '../controllers/schdule_surgeries_controller.dart';

class SchduleSurgeriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchduleSurgeriesController>(
      () => SchduleSurgeriesController(),
    );
  }
}
