import 'dart:convert';

import 'package:venus/app/core/services/utils.dart';

class LocalPref {
  static void saveDataPref(String key, String value) {
    Utils.getStorage.write(key, value);
  }

  static dynamic getPrefData(String key) {
    var userData = Utils.getStorage.read(key);
    if (userData != null) {
      return (jsonDecode(userData));
    } else {
      return null;
    }
  }
}

// LoginResponse userData = LoginResponse();
