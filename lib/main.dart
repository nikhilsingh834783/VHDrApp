/// changes done by Divyanshi
library;

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/core/services/push_notification_service.dart';
import 'app/core/them/const_color.dart';
import 'app/modules/NoInternet/bindings/no_internet_binding.dart';
import 'app/modules/NoInternet/controllers/no_internet_controller.dart';
import 'app/modules/opdAppointments/model/ment_model.dart';
import 'app/routes/app_pages.dart';

RxBool hideBottomBar = false.obs;
List<AppointMentLsitData> appointMentsDate = [];
List<AppointMentLsitData> procedureDates = [];
int calenderType = 0;
bool previousDateEnable = false;
String? fcmToken;

NotificationService firebaseService = NotificationService();
Map<String, dynamic> dataFromNotification = {};

String? mainChatRoomId;
int? mainUserTypeId;
bool showPopupOnBoard = false;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Received a message while in foreground!');
    if (message.notification != null) {
      log('Notification Title: ${message.notification!.title}');
      log('Notification Body: ${message.notification!.body}');
      _showNotification(message);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await getFcmToken();
  if (await Permission.notification.isGranted) {
    initializeNotificationSettings();
  }
  await requestNotificationPermission();

  runApp(
    Builder(
      builder: (context) {
        Get.put(NoInternetController());
        return GetMaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: ConstColor.whiteColor),
          initialBinding: NoInternetBinding(),
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          navigatorObservers: [
            NavigatorObserver(),
          ],
        );
      },
    ),
  );
}

// Future<void> getFcmToken() async {
//   try {
// if(Platform.isAndroid)
//   {
//     fcmToken = await FirebaseMessaging.instance.getToken();
//
//     if (fcmToken != null) {
//       debugPrint("FCM Token fetched successfully: $fcmToken");
//     } else {
//       log("Failed to retrieve FCM Token.");
//     }
//   }
//
//     if (Platform.isIOS) {
//       String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//       if (apnsToken != null) {
//         log("APNS Token (iOS) retrieved: $apnsToken");
//       } else {
//         log("APNS Token not available.");
//       }
//     }
//   } catch (e, stacktrace) {
//     log("Error fetching FCM Token: $e", error: e, stackTrace: stacktrace);
//   }
// }

Future<void> getFcmToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log("Notification method ");
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.getAPNSToken();
        log(" APNS TOKEN FOR IOS : ${await FirebaseMessaging.instance.getAPNSToken()}");
      }
      fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        debugPrint("FCM Token fetched successfully: $fcmToken");
      } else {
        log("Failed to retrieve FCM Token.");
      }
    } else {
      log("Notification permission denied or restricted.");
    }
  } catch (e, stacktrace) {
    log("Error fetching FCM/APNS Token: $e", error: e, stackTrace: stacktrace);
  }
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  log('iOS local notification received: $title $body');
}

void initializeNotificationSettings() async {
  var androidInitSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  var iosInitSettings = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  var initSettings = InitializationSettings(
      android: androidInitSettings, iOS: iosInitSettings);

  flutterLocalNotificationsPlugin.initialize(initSettings);
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log("Received a foreground message: ${message.notification?.title}");
    _showNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log("Notification clicked and app opened: ${message.notification?.title}");
  });

  await firebaseService.initialize();
}

_showNotification(RemoteMessage message) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'demo',
    'divya',
    importance: Importance.high,
    priority: Priority.high,
    showWhen: true,
  );
  var iosPlatformChannelSpecifics = const DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    message.notification?.hashCode ?? 0,
    message.notification?.title ?? 'No title',
    message.notification?.body ?? 'No body',
    platformChannelSpecifics,
    payload: 'Notification Payload',
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    log("Handling a background message: ${message.notification?.title}");

    if (message.notification != null) {
      await _showNotification(message);
      // _handleNotificationTap(message);
    } else {
      log("Notification content is null.");
    }
  } catch (e, stacktrace) {
    log("Error handling background message: $e",
        error: e, stackTrace: stacktrace);
  }
}

// Future<void> _handleNotificationTap(RemoteMessage message) async {
//   log('Notification tapped with data: ${message.data}');
// }

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var androidVersion = androidInfo.version.sdkInt;

    if (androidVersion >= 13) {
      var permissionStatus = await Permission.notification.status;

      if (permissionStatus.isDenied) {
        var status = await Permission.notification.request();

        if (status.isGranted) {
          debugPrint("Notification permission granted on Android.");
        } else if (status.isPermanentlyDenied) {
          debugPrint(
              "Notification permission permanently denied on Android. Please enable it in settings.");
          openAppSettings();
        } else {
          debugPrint("Notification permission denied on Android.");
        }
      } else if (permissionStatus.isGranted) {
        debugPrint("Notification permission already granted on Android.");
      } else if (permissionStatus.isLimited) {
        debugPrint("Notification permission is limited on Android.");
      } else if (permissionStatus.isRestricted) {
        debugPrint("Notification permission is restricted on Android.");
      }
    } else {
      debugPrint(
          "No explicit notification permission required on Android versions below 13.");
    }
  } else if (Platform.isIOS) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Notification permission granted on iOS.");
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("Notification permission denied on iOS.");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("Provisional notification permission granted on iOS.");
    } else {
      debugPrint(
          "Notification permission restricted or not determined on iOS.");
    }
  }
}
