import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../models/contact_model.dart';

class ContactController extends GetxController {
  bool apiCall = false;
  var bottomBarController = Get.put(BottomBarController());
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController contactScrollController = ScrollController();
  List<ContactListData> contactListData = [];
  final searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void onInit() {
    super.onInit();
    getContacts();
    contactScrollController.addListener(() {
      if (contactScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        bottomBarController.update();
      } else if (contactScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
      }
    });
  }

  getContacts({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "searchText": searchPrefix ?? '',
    };
    apiCall = true;
    String apiUrl = getContactsApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    ContactResponse contactResponse = ContactResponse.fromJson(finalData.data);
    if (contactResponse.statusCode == 200) {
      if (contactResponse.data != null && contactResponse.data!.isNotEmpty) {
        contactListData = contactResponse.data!;
      }
    } else if (contactResponse.statusCode == 400) {
      contactListData = [];
    } else if (contactResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
