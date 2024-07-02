import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venus/app/modules/bottomBar/controllers/bottom_bar_controller.dart';

class ContactController extends GetxController {
  var bottomBarController = Get.put(BottomBarController());
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final count = 0.obs;

  void increment() => count.value++;
}
