import 'dart:convert';

import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/main.dart';

import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../login/views/login_view.dart';
import '../model/lab_report_model.dart';

class LabReportsController extends GetxController {
  final count = 0.obs;
  bool apiCall = false;
  List<ReportsAllData> labReportsList = [];
  List<ReportListData> allReportsList = [];
  List allDatesList = [];
  void increment() => count.value++;
  final ScrollController scrollController1 = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  List<ScrollController> scrollController3 = [];
  final ScrollController scrollController4 = ScrollController();
  bool _isUpdatingScrollPosition = false;
  bool scroll1 = false;
  bool scroll2 = false;
  bool scroll3 = false;
  bool showSwipe = false;

  void _syncScroll() {
    scroll1 = true;
    scroll3 = false;
    scroll2 = false;
    if (scrollController1.hasClients && scrollController2.hasClients) {
      if (scrollController1.offset != scrollController2.offset) {
        scrollController2.jumpTo(scrollController1.offset);
      }
    }
    for (int i = 0; i < scrollController3.length; i++) {
      if (scrollController1.offset != scrollController3[i].offset) {
        scrollController3[i].jumpTo(scrollController1.offset);
      }
    }
  }

  void _syncScroll2() {
    if (scrollController2.hasClients && scrollController1.hasClients) {
      if (scrollController2.offset != scrollController1.offset) {
        scrollController1.jumpTo(scrollController2.offset);
      }
    }
    for (int i = 0; i < scrollController3.length; i++) {
      if (scrollController2.offset != scrollController3[i].offset) {
        scrollController3[i].jumpTo(scrollController2.offset);
      }
    }
  }

  addScrollMultiple() {
    scroll1 = false;
    scroll2 = false;
    scroll3 = true;
    for (int i = 0; i < allDatesList.length; i++) {
      final controller = ScrollController();
      controller.addListener(() {
        if (!_isUpdatingScrollPosition) {
          _isUpdatingScrollPosition = true;
          for (var otherController in scrollController3) {
            if (otherController != controller && otherController.hasClients) {
              otherController.jumpTo(controller.offset);
              scrollController1.jumpTo(controller.offset);
            }
          }
          _isUpdatingScrollPosition = false;
        }
      });
      scrollController3.add(controller);
    }
  }

  getLabReporst(
      {required String ipdNo,
      required String uhidNo,
      bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "ipdNo": ipdNo, "uhid": uhidNo};
    apiCall = true;
    String apiUrl = ConstApiUrl.getLabReports;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    if (finalData.statusCode == 200) {
      var responseData = jsonDecode(finalData.data);
      LabReportModel reponse = LabReportModel.fromJson(responseData);
      allReportsList = reponse.data!.data!;
      labReportsList = [];
      scrollController3 = [];

      for (int i = 0; i < allReportsList.length; i++) {
        labReportsList.addAll(allReportsList[i].data!);
      }

      for (int i = 0; i < labReportsList.length; i++) {
        if (allDatesList.contains(
            "${labReportsList[i].date.toString().split('-')[0]}-${labReportsList[i].date.toString().split('-')[1]}")) {
        } else {
          allDatesList.add(
              "${labReportsList[i].date.toString().split('-')[0]}-${labReportsList[i].date.toString().split('-')[1]}");
        }
      }

      apiCall = false;
      addScrollMultiple();
      scrollController1.addListener(_syncScroll);
      scrollController2.addListener(_syncScroll2);
      if (allReportsList.isEmpty) {
        hideBottomBar.value = false;
        update();
      }
      update();
    } else if (finalData.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (finalData.statusCode == 400) {
      apiCall = false;
    } else {
      apiCall = false;
      Get.rawSnackbar(message: "Something went wrong");
    }
    //   update();
  }
}
