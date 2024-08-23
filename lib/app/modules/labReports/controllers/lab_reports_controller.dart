import 'dart:convert';

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
import '../model/lab_report_model.dart';

class LabReportsController extends GetxController {
  final count = 0.obs;
  bool apiCall = false;
  List commonList = [];
  List<ReportsAllData> labReportsList = [];
  List<ReportListData> allReportsList = [];
  List dataContain = [];
  List allDatesList = [];
  void increment() => count.value++;
  final ScrollController scrollController1 = ScrollController();
  final ScrollController allscrollController = ScrollController();
  final ScrollController scrollController2 = ScrollController();
  ScrollController scrollControllerx = ScrollController();
  List<ScrollController> scrollController3 = [];
  final ScrollController scrollController4 = ScrollController();
  bool _isUpdatingScrollPosition = false;
  var bottomBarController = Get.put(BottomBarController());
  bool scroll1 = false;
  bool scroll2 = false;
  bool scroll3 = false;
  bool showSwipe = false;

  void _syncScroll() {
    if (scrollController1.hasClients && scrollController2.hasClients) {
      if (scrollController1.offset != scrollController2.offset) {
        scrollController2.jumpTo(scrollController1.offset);
      }
    }

    if (scrollController1.hasClients && scrollControllerx.hasClients) {
      if (scrollController1.offset != scrollControllerx.offset) {
        scrollControllerx.jumpTo(scrollController1.offset);
      }
    }
  }

  void syncScroll3() {
    if (scrollControllerx.hasClients && scrollController2.hasClients) {
      if (scrollControllerx.offset != scrollController2.offset) {
        scrollController2.jumpTo(scrollControllerx.offset);
      }
    }

    if (scrollControllerx.hasClients && scrollController1.hasClients) {
      if (scrollController1.offset != scrollController1.offset) {
        scrollController1.jumpTo(scrollControllerx.offset);
      }
    }
  }

  void _syncScroll2() {
    if (scrollController2.hasClients && scrollController1.hasClients) {
      if (scrollController2.offset != scrollController1.offset) {
        scrollController1.jumpTo(scrollController2.offset);
      }
    }
    if (scrollController2.hasClients && scrollControllerx.hasClients) {
      if (scrollController2.offset != scrollControllerx.offset) {
        scrollControllerx.jumpTo(scrollController2.offset);
      }
    }
  }

  scrollLister() {
    allscrollController.addListener(() {
      if (allscrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        bottomBarController.update();
      } else if (allscrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
      }
    });
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
    String apiUrl = getLabReports;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    if (finalData.statusCode == 200) {
      var responseData = jsonDecode(finalData.data);

      commonList = responseData['data']['Data'];
      scrollController1.addListener(_syncScroll);
      scrollController2.addListener(_syncScroll2);
      apiCall = false;
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
    update();
  }

  // getLabReporst(
  //     {required String ipdNo,
  //     required String uhidNo,
  //     bool isLoader = true}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //   String loginId = prefs.getString('loginId') ?? '';
  //   Map data = {"loginId": loginId, "ipdNo": ipdNo, "uhid": uhidNo};
  //   apiCall = true;
  //   String apiUrl = ConstApiUrl.getLabReports;
  //   dio_package.Response finalData =
  //       await APIServices.postMethodWithHeaderDioMapData(
  //           body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
  //   if (finalData.statusCode == 200) {
  //     var responseData = jsonDecode(finalData.data);
  //     LabReportModel reponse = LabReportModel.fromJson(responseData);
  //     allReportsList = reponse.data!.data!;
  //     labReportsList = [];
  //     scrollController3 = [];

  //     for (int i = 0; i < allReportsList.length; i++) {
  //       labReportsList.addAll(allReportsList[i].data!);
  //     }

  //     for (int i = 0; i < labReportsList.length; i++) {
  //       if (allDatesList.contains(
  //           "${labReportsList[i].date.toString().split('-')[0]}-${labReportsList[i].date.toString().split('-')[1]}")) {
  //       } else {
  //         allDatesList.add(
  //             "${labReportsList[i].date.toString().split('-')[0]}-${labReportsList[i].date.toString().split('-')[1]}");
  //       }
  //     }

  //     apiCall = false;
  //     addScrollMultiple();
  //     scrollController1.addListener(_syncScroll);
  //     scrollController2.addListener(_syncScroll2);
  //     if (allReportsList.isEmpty) {
  //       hideBottomBar.value = false;
  //       update();
  //     }
  //     update();
  //   } else if (finalData.statusCode == 401) {
  //     prefs.clear();
  //     Get.offAll(const LoginView());
  //     Get.rawSnackbar(
  //         message: 'Your session has expired. Please log in again to continue');
  //   } else if (finalData.statusCode == 400) {
  //     apiCall = false;
  //   } else {
  //     apiCall = false;
  //     Get.rawSnackbar(message: "Something went wrong");
  //   }
  //   //   update();
  // }

  dateWiseReport(List<ReportsAllData> allDates) {
    List allDatesListq = [];
    for (int i = 0; i < allDates.length; i++) {
      if (allDatesListq.contains(
          "${allDates[i].date.toString().split('-')[0]}-${allDates[i].date.toString().split('-')[1]}")) {
      } else {
        allDatesListq.add(
            "${allDates[i].date.toString().split('-')[0]}-${allDates[i].date.toString().split('-')[1]}");
      }
    }
    return allDatesListq;
  }

  getKey(List data) {
    List alldates = [];
    for (var response in data) {
      response.forEach((key, value) {
        if (key == "formattest" ||
            key == "TestName" ||
            key == "NormalRange" ||
            key == "Unit" ||
            key == 'RowNo') {
        } else {
          if (alldates.contains(
              "${key.toString().split('-')[0]}-${key.toString().split('-')[1]}")) {
          } else {
            alldates.add(
                "${key.toString().split('-')[0]}-${key.toString().split('-')[1]}");
          }
        }
      });
    }
    return alldates;
  }

  getKey1(List data) {
    List alldates = [];
    List alldates1 = [];
    for (var response in data) {
      response.forEach((key, value) {
        if (key == "formattest" ||
            key == "TestName" ||
            key == "NormalRange" ||
            key == "Unit" ||
            key == 'RowNo') {
        } else {
          if (alldates.contains(
              "${key.toString().split('-')[0]}-${key.toString().split('-')[1]}")) {
          } else {
            alldates.add(
                "${key.toString().split('-')[0]}-${key.toString().split('-')[1]}");
            alldates1.add(key.toString());
          }
        }
      });
    }
    return alldates1;
  }
}
