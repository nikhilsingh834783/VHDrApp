import 'package:dio/dio.dart' as dio_package;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_common_widgets/common_import.dart';
import '../../../core/services/api_service.dart';
import '../../login/views/login_view.dart';
import '../model/radio_logy_model.dart';

class RadiologyReportController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;
  bool apiCall = false;
  List<RadioLogyList> allRadiologyList = [];

  getRadioLogyReport(
      {required String ipdNo,
      required String uhidNo,
      bool isLoader = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String loginId = prefs.getString('loginId') ?? '';
    Map data = {"loginId": loginId, "ipdNo": ipdNo, "uhid": uhidNo};
    apiCall = true;
    String apiUrl = ConstApiUrl.getRadioLogyReports;
    dio_package.Response finalData =
        await APIServices.postMethodWithHeaderDioMapData(
            body: data, apiUrl: apiUrl, token: token, isShowLoader: isLoader);
    RadioLogyModel patientResponse = RadioLogyModel.fromJson(finalData.data);

    if (patientResponse.statusCode == 200) {
      if (patientResponse.data != null && patientResponse.data!.isNotEmpty) {
        allRadiologyList = patientResponse.data!;
      }
      apiCall = false;
      update();
    } else if (patientResponse.statusCode == 401) {
      prefs.clear();
      Get.offAll(const LoginView());
      // Get.rawSnackbar(message: finalData.data['message']);
      Get.rawSnackbar(
          message: 'Your session has expired. Please log in again to continue');
    } else if (patientResponse.statusCode == 400) {
      apiCall = false;
    } else {
      apiCall = false;
      Get.rawSnackbar(message: "Something went wrong");
    }
    update();
  }
}
