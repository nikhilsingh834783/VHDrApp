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
      final response = await dio.post(
        apiUrl!,
        data: body,
        options: diopackage.Options(
          validateStatus: (_) => true,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (isShowLoader) {
        EasyLoading.dismiss();
      }
      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
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
      final response = await dio.get(
        apiUrl!,
        queryParameters: queryData,
        options: diopackage.Options(
          validateStatus: (_) => true,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
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
      final response = await dio.delete(
        data: queryData,
        apiUrl!,
        options: diopackage.Options(
          validateStatus: (_) => true,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
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
      final response = await dio.put(
        apiUrl!,
        queryParameters: queryData,
        options: diopackage.Options(
          validateStatus: (_) => true,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();
      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  static dynamic getMethodWithoutHeaderDio(
      {String? apiUrl,
      bool isShowLoader = true,
      Map<String, dynamic>? queryData,
      bool? headerChange}) async {
    if (isShowLoader) {
      EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    }

    var dio = diopackage.Dio();
    try {
      final response = await dio.get(
        apiUrl!,
        queryParameters: queryData,
        options: diopackage.Options(
          validateStatus: (_) => true,
          headers: {
            "X-RapidAPI-Host": "world-airports-directory.p.rapidapi.com",
            "X-RapidAPI-Key":
                "52ba1fe3d4msh68838eab5fd8e61p1e93f9jsnda8d255093f3",
          },
        ),
      );
      if (isShowLoader) {
        EasyLoading.dismiss();
      }

      return response;
    } catch (exception) {
      EasyLoading.dismiss();

      if (exception.toString().contains('SocketException')) {
        return 'NetworkError';
      } else {
        return null;
      }
    }
  }

  static dynamic postWithDioForlogin(String url, var body) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    var dio = diopackage.Dio();
    try {
      final diopackage.Response response = await dio.post(
        url,
        data: body,
        options: diopackage.Options(
            validateStatus: (_) => true,
            headers: {'Content-Type': 'application/json'}),
      );

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
      } else {
        Get.rawSnackbar(message: exception.toString());
        return null;
      }
    }
  }
}
