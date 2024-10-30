// import 'package:get/get.dart';
//
// import '../controllers/insurance_companies_controller.dart';
//
// class InsuranceCompaniesBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<InsuranceCompaniesController>(
//       () => InsuranceCompaniesController(),
//     );
//   }
// }
import 'package:get/get.dart';

import '../controllers/insurance_companies_controller.dart';

class InsuranceCompaniesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsuranceCompaniesController>(
        () => InsuranceCompaniesController());
  }
}
