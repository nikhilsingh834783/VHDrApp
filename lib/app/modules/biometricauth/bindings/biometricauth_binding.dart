import 'package:get/get.dart';

import '../controllers/biometricauth_controller.dart';

class BiometricauthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiometricauthController>(
      () => BiometricauthController(),
    );
  }
}
