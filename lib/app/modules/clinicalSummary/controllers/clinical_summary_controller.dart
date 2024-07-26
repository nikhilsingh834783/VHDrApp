import 'package:get/get.dart';

class ClinicalSummaryController extends GetxController {
  final count = 0.obs;
  List selectedIndex = [];

  void increment() => count.value++;
}
