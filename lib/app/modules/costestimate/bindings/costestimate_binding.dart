import 'package:get/get.dart';

import '../controllers/costestimate_controller.dart';

class CostestimateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CostestimateController>(
      () => CostestimateController(),
    );
  }
}
