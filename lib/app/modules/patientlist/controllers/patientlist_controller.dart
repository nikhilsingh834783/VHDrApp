import 'dart:convert';

import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/patientlist/model/patient_model.dart';
import 'package:venus/app/modules/patientlist/views/widgets/floor_checkbox.dart';
import 'package:venus/app/modules/patientlist/views/widgets/organization_checkbox.dart';
import 'package:venus/app/modules/patientlist/views/widgets/ward_checkbox.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../model/dahboard_filters.dart';

class PatientlistController extends GetxController {
  final count = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> selectedOrganizationList = [];
  List<String> selectedFloorList = [];
  List<String> selectedWardList = [];
  List<PatientListModel> patientList = [];
  List<PatientListModel>? filterPatientList;
  List<Orgs> orgsList = [];
  List<Floors> floorsList = [];
  List<Wards> wardList = [];
  int? sortBySelected;
  final ScrollController patientScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  final TextEditingController searchController = TextEditingController();
  bool showShortButton = true;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    patientScrollController.addListener(() {
      if (patientScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (patientScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });
    // getPatientList();
    getFilterData(isLoader: true);
    getDashboardFilters();
  }

  getPatientList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String apiUrl = ConstApiUrl.patientList;
    dio_package.Response finalData = await APIServices.getMethodWithHeaderDio(
        apiUrl: apiUrl, token: token, isShowLoader: true);
    if (finalData.statusCode == 200) {
      // final messages =
      //     List<Map<String, dynamic>>.from(finalData.data as List<dynamic>);
      // List<PatientListModel> finalList =
      //     messages.map((m) => PatientListModel.fromJson(m)).toList();
      // patientList = finalList;
      // update();
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  getDashboardFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = ConstApiUrl.dashboardFilters;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token);
    if (finalData.statusCode == 200) {
      DashBoardFiltersModels filterResponse =
          DashBoardFiltersModels.fromJson(finalData.data);
      if (filterResponse.data != null) {
        orgsList = filterResponse.data!.orgs ?? [];
        floorsList = filterResponse.data!.floors ?? [];
        wardList = filterResponse.data!.wards ?? [];
      }
      update();
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
  }

  getFilterData({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "prefixText": searchPrefix ?? '',
      "orgs": selectedOrganizationList,
      "floors": selectedFloorList,
      "wards": selectedWardList
    };
    print(jsonEncode(data));
    String apiUrl = ConstApiUrl.filterPatientData;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    PatientResponseModel patientResponse =
        PatientResponseModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        PatientResponseModel patientResponse =
            PatientResponseModel.fromJson(finalData.data);
        filterPatientList = patientResponse.data;
      } else {
        filterPatientList = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      filterPatientList = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getSortData({bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "sortType": sortBySelected == 0
          ? "Pt Name -> asc"
          : sortBySelected == 1
              ? "Pt Name -> desc"
              : sortBySelected == 2
                  ? "Stay Days - L -> H"
                  : "Stay Days - H -> L"
    };
    print(jsonEncode(data));
    String apiUrl = ConstApiUrl.sortPatientData;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    PatientResponseModel patientResponse =
        PatientResponseModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        PatientResponseModel patientResponse =
            PatientResponseModel.fromJson(finalData.data);
        filterPatientList = patientResponse.data;
      } else {
        filterPatientList = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      filterPatientList = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  Future<void> registerFiltterBottomSheet() async {
    showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        isDismissible: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.90,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: GetBuilder<PatientlistController>(builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.crossLength * 0.020),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Sizes.crossLength * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          AppText(
                            text: 'Filter by',
                            fontSize: Sizes.px20,
                            fontColor: ConstColor.blackTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(ConstAsset.closeIcon))
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Sizes.crossLength * 0.025,
                              ),
                              AppText(
                                text: 'Organization',
                                fontSize: Sizes.px15,
                                fontColor: ConstColor.blackTextColor,
                                fontWeight: FontWeight.w800,
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.010,
                              ),
                              organizationCheckBoxes(controller: controller),
                              SizedBox(
                                height: Sizes.crossLength * 0.015,
                              ),
                              AppText(
                                text: 'Floor',
                                fontSize: Sizes.px15,
                                fontColor: ConstColor.blackTextColor,
                                fontWeight: FontWeight.w800,
                              ),
                              SizedBox(
                                height: Sizes.crossLength * 0.010,
                              ),
                              floorCheckBoxes(controller: controller),
                              SizedBox(
                                height: Sizes.crossLength * 0.015,
                              ),
                              AppText(
                                text: 'Ward',
                                fontSize: Sizes.px15,
                                fontColor: ConstColor.blackTextColor,
                                fontWeight: FontWeight.w800,
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.010),
                              ),
                              wardCheckBoxes(controller: controller),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: getDynamicHeight(size: 0.050),
                              child: AppButton(
                                  radius: 50,
                                  text: 'Apply',
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (selectedOrganizationList.isNotEmpty ||
                                        selectedFloorList.isNotEmpty ||
                                        selectedWardList.isNotEmpty) {
                                      Navigator.pop(context);
                                      getFilterData();
                                    } else {
                                      Get.rawSnackbar(
                                          message:
                                              "Please select options to short");
                                    }
                                  }),
                            )),
                            SizedBox(
                              width: getDynamicHeight(size: 0.020),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: getDynamicHeight(size: 0.050),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    // padding: const EdgeInsets.only(top: 1),
                                    backgroundColor: ConstColor.whiteColor,
                                    side: const BorderSide(
                                        width: 1.0,
                                        color: ConstColor.black6B6B6B),
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    selectedOrganizationList = [];
                                    selectedFloorList = [];
                                    selectedWardList = [];
                                    getFilterData();
                                    Navigator.pop(context);
                                    controller.update();
                                  },
                                  child: AppText(
                                    text: 'Reset All',
                                    fontSize: Sizes.px16,
                                    fontWeight: FontWeight.w500,
                                    fontColor: ConstColor.black6B6B6B,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getDynamicHeight(size: 0.025),
                      ),
                    ],
                  ),
                );
              }),
            ));
  }

  Future<void> sortBy() async {
    showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        isDismissible: true,
        useSafeArea: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: GetBuilder<PatientlistController>(builder: (controller) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.crossLength * 0.020),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Sizes.crossLength * 0.025,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          AppText(
                            text: 'Sort by',
                            fontSize: Sizes.px20,
                            fontColor: ConstColor.blackTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(ConstAsset.closeIcon))
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Sizes.crossLength * 0.025,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  sortBySelected = 0;
                                  controller.update();
                                  getSortData(isLoader: true);
                                  Get.back();
                                },
                                child: Row(
                                  children: [
                                    AppText(
                                      text: 'Patient Name [A-Z]',
                                      fontSize: Sizes.px14,
                                      fontColor: sortBySelected == 0
                                          ? ConstColor.buttonColor
                                          : ConstColor.blackTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              const Divider(
                                color: ConstColor.dividerColor,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  sortBySelected = 1;
                                  controller.update();
                                  getSortData(isLoader: true);
                                  Get.back();
                                },
                                child: Row(
                                  children: [
                                    AppText(
                                      text: 'Patient Name [Z-A]',
                                      fontSize: Sizes.px14,
                                      fontColor: sortBySelected == 1
                                          ? ConstColor.buttonColor
                                          : ConstColor.blackTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              const Divider(
                                color: ConstColor.dividerColor,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  sortBySelected = 2;
                                  controller.update();
                                  getSortData(isLoader: true);
                                  Get.back();
                                },
                                child: Row(
                                  children: [
                                    AppText(
                                      text: 'Stay Days [Low - High]',
                                      fontSize: Sizes.px14,
                                      fontColor: sortBySelected == 2
                                          ? ConstColor.buttonColor
                                          : ConstColor.blackTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              const Divider(
                                color: ConstColor.dividerColor,
                                thickness: 1,
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  sortBySelected = 3;
                                  controller.update();
                                  getSortData(isLoader: true);
                                  Get.back();
                                },
                                child: Row(
                                  children: [
                                    AppText(
                                      text: 'Stay Days [High-Low]',
                                      fontSize: Sizes.px14,
                                      fontColor: sortBySelected == 3
                                          ? ConstColor.buttonColor
                                          : ConstColor.blackTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getDynamicHeight(size: 0.015),
                              ),
                              const Divider(
                                color: ConstColor.dividerColor,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ));
  }
}
