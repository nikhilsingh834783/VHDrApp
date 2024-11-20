import 'package:dio/dio.dart' as diopackage;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class APIServices {
  static dynamic postMethodWithHeaderDioMapData(
      {String? apiUrl,
      String? token,
      Map? body,
      bool isShowLoader = true}) async {
    if (isShowLoader) {
      EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    }
    var dio = diopackage.Dio();
    try {
      final response = await dio
          .post(
            apiUrl!,
            data: body,
            options: diopackage.Options(
              validateStatus: (_) => true,
              headers: {
                "Authorization": "Bearer $token",
              },
            ),
          )
          .timeout(const Duration(seconds: 45));
      if (isShowLoader) {
        EasyLoading.dismiss();
      }
      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Please check your internet connection.");
        }

        return 'NetworkError';
      } else if (exception.toString().contains('TimeoutException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Server Error.");
        }

        return 'NetworkError';
      } else {
        Get.rawSnackbar(message: exception.toString());
        return null;
      }
    }
  }

//get dio api
  static dynamic getMethodWithHeaderDio(
      {String? apiUrl,
      String? token,
      bool isShowLoader = true,
      Map<String, dynamic>? queryData,
      bool? headerChange}) async {
    if (isShowLoader) {
      EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    }
    var dio = diopackage.Dio();
    try {
      final response = await dio
          .get(
            apiUrl!,
            queryParameters: queryData,
            options: diopackage.Options(
              validateStatus: (_) => true,
              headers: {
                "Authorization": "Bearer $token",
              },
            ),
          )
          .timeout(const Duration(seconds: 45));
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Please check your internet connection.");
        }

        return 'NetworkError';
      } else if (exception.toString().contains('TimeoutException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Server Error.");
        }

        return 'NetworkError';
      } else {
        Get.rawSnackbar(message: exception.toString());
        return null;
      }
    }
  }

  static dynamic deleteMethodWithHeaderDio(
      {String? apiUrl,
      String? token,
      bool isShowLoader = true,
      Map<String, dynamic>? queryData,
      bool? headerChange}) async {
    if (isShowLoader) {
      EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    }
    var dio = diopackage.Dio();
    try {
      final response = await dio
          .delete(
            data: queryData,
            apiUrl!,
            options: diopackage.Options(
              validateStatus: (_) => true,
              headers: {
                "Authorization": "Bearer $token",
              },
            ),
          )
          .timeout(const Duration(seconds: 45));
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Please check your internet connection.");
        }

        return 'NetworkError';
      } else if (exception.toString().contains('TimeoutException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Server Error.");
        }

        return 'NetworkError';
      } else {
        Get.rawSnackbar(message: exception.toString());
        return null;
      }
    }
  }

  static dynamic putMethodWithHeaderDio(
      {String? apiUrl,
      String? token,
      bool isShowLoader = true,
      Map<String, dynamic>? queryData,
      bool? headerChange}) async {
    if (isShowLoader) {
      EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    }
    var dio = diopackage.Dio();
    try {
      final response = await dio
          .put(
            apiUrl!,
            queryParameters: queryData,
            options: diopackage.Options(
              validateStatus: (_) => true,
              headers: {
                "Authorization": "Bearer $token",
              },
            ),
          )
          .timeout(const Duration(seconds: 45));
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Please check your internet connection.");
        }

        return 'NetworkError';
      } else if (exception.toString().contains('TimeoutException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Server Error.");
        }
        return 'NetworkError';
      } else {
        Get.rawSnackbar(message: exception.toString());
      }
    }
  }

  static dynamic postWithDioForlogin(String url, var body) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    var dio = diopackage.Dio();
    try {
      final diopackage.Response response = await dio
          .post(
            url,
            data: body,
            options: diopackage.Options(
                validateStatus: (_) => true,
                headers: {'Content-Type': 'application/json'}),
          )
          .timeout(const Duration(seconds: 45));

      EasyLoading.dismiss();
      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Please check your internet connection.");
        }

        return 'NetworkError';
      } else if (exception.toString().contains('TimeoutException')) {
        if (Get.isSnackbarOpen) {
        } else {
          Get.rawSnackbar(message: "Server Error.");
        }
        return 'NetworkError';
      } else {
        Get.rawSnackbar(message: exception.toString());
      }
    }
  }
}
