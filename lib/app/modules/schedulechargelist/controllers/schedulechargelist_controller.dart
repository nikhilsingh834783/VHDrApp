import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venus/app/modules/schedulechargelist/model/operation_class_model.dart';

import '../../../../main.dart';
import '../../../app_common_widgets/common_import.dart';
import '../../../app_common_widgets/multi_dropdown_widget.dart';
import '../../../core/services/api_service.dart';
import '../../bottomBar/controllers/bottom_bar_controller.dart';
import '../../login/views/login_view.dart';
import '../../otscheduler/model/operation_name_model.dart';
import '../model/doctor_visit_model.dart';
import '../model/rooms_model.dart';
import '../model/surgery_model.dart';
import '../views/widgets/operation_name.dart';

class SchedulechargelistController extends GetxController {
  int selectedTab = 0;
  List<RoomListData> roomsData = [];
  List<DoctorVisitListData> doctorsListData = [];
  List<OperationListData> operationClassListData = [];
  List<SurgeryListData> surgeryListData = [];
  String? selectedGender;
  List<String> highRiskList = ['Yes', "No"];
  List<String> genderList = ['Male', "Female", "Other"];
  final ScrollController roomScrollController = ScrollController();
  final ScrollController vistScrollController = ScrollController();
  final ScrollController surgryScrollController = ScrollController();
  var bottomBarController = Get.put(BottomBarController());
  final searchController = TextEditingController();
  List<OperationNameList> operationNameListData = [];
  List<OperationNameList>? searchOperationNameListData;
  RxList<ValueItem<dynamic>> operationNameListData1 =
      <ValueItem<dynamic>>[].obs;
  RxList<ValueItem<dynamic>> selectedOperationNameListData1 =
      <ValueItem<dynamic>>[].obs;
  final operationNameController = TextEditingController();
  final operationClassController = TextEditingController();
  String? selectedClassId;
  List<OperationNameList> selectedOperationList = [];
  List<int> selectedOperationId = [];
  CustomPopupMenuController operationNamePopupController =
      CustomPopupMenuController();
  CustomPopupMenuController operationClassPopupController =
      CustomPopupMenuController();

  scrollListner() {
    roomScrollController.addListener(() {
      if (roomScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (roomScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });

    vistScrollController.addListener(() {
      if (vistScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (vistScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });

    surgryScrollController.addListener(() {
      if (surgryScrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        hideBottomBar = false.obs;
        update();
        // print("=====Up");
        bottomBarController.update();
        // update(0.0, true);
      } else if (surgryScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideBottomBar = true.obs;
        update();
        bottomBarController.update();
        // print("=====Down");
      }
    });
  }

  void onOptionSelected(
    List<ValueItem<dynamic>> value,
  ) {
    selectedOperationNameListData1.value = value;
    // print("$selectedregionsList");
  }
  // update();

  getRooms({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "searchText": searchPrefix ?? '',
    };
    String apiUrl = roomsApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    RoomListModel patientResponse = RoomListModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        roomsData = patientResponse.data!;
      } else {
        roomsData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      roomsData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getDoctorVisit({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "searchText": searchPrefix ?? '',
    };
    String apiUrl = doctorVisitApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    DoctorVisitModel patientResponse =
        DoctorVisitModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        doctorsListData = patientResponse.data!;
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      doctorsListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getSurgeries({String? searchPrefix, bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
      "searchText": searchPrefix ?? '',
      "operationName": selectedOperationId,
      "classId": selectedClassId
    };
    String apiUrl = surgeryApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    SurgeryModel patientResponse = SurgeryModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        surgeryListData = patientResponse.data!;
      } else {
        surgeryListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      surgeryListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  getOperationClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {
      "loginId": loginId,
    };
    String apiUrl = getOperationClassApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
    OperationClassModel patientResponse =
        OperationClassModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        operationClassListData = patientResponse.data!;
      } else {
        operationClassListData = [];
      }
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      operationClassListData = [];
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }

  Future<void> selectOperationName() async {
    showModalBottomSheet(
      context: Get.context!,
      elevation: 0,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: ConstColor.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: Get.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: const OperationNameListView()),
      ),
    ).whenComplete(() {
      if (selectedOperationId.isNotEmpty && selectedClassId != null) {
        getSurgeries(isLoader: true);
      }
    });
  }

  searchAdditionalSurgeon(String text) {
    if (text.trim().isEmpty) {
      searchOperationNameListData = null;
    } else {
      searchOperationNameListData = [];
      for (var userDetail in operationNameListData) {
        if (userDetail.operationName!
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchOperationNameListData!.add(userDetail);
        }
      }
    }
    update();
  }

  getOperationName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "operationNames": "", 'docId': ''};

    String apiUrl = getOperationNameApi;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: false);
    OperationNameModel patientResponse =
        OperationNameModel.fromJson(finalData.data);
    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        operationNameListData = patientResponse.data!;

        if (operationNameListData.isNotEmpty) {
          var skillsList = operationNameListData;
          operationNameListData1.value = skillsList.map((e) {
            return ValueItem(label: e.operationName!, value: e.id!);
          }).toList();
          // selectedSkillList.value = skilldropDownList
          //     .where((e) => prefillSkills.contains(e.value))
          //     .toList();
          // update();
        }
      } else {}
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
    } else {
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
