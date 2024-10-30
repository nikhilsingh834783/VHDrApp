import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../modules/bottomBar/controllers/bottom_bar_controller.dart';
import '../them/const_color.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  showBadge: true,
);

var controller = Get.put(BottomBarController());

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  dataFromNotification = message.data;
  // if (Platform.isIOS) {
  //   setCurrentScreenName(screenName: ConstString.notificatiRecieve);
  // }
  await Firebase.initializeApp();
}

bool isFlutterLocalNotificationsInitialized = false;

class NotificationService {
  static int? feedId;
  Future<String?> getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      assert(token != null);
      return token!;
    } catch (e) {}
    return null;
  }

  Future<void> initialize() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .createNotificationChannel(channel);
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');


    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        dataFromNotification = jsonDecode(payload!);
        _handleNavigationOnNotificationClick();
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        dataFromNotification = message.data;

        _handleNavigationOnNotificationClick();
      }
    });
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      dataFromNotification = jsonDecode(details.payload!);
      _handleNavigationOnNotificationClick();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      dataFromNotification = message.data;

      if (Platform.isIOS) {
      } else {
        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            payload: jsonEncode(message.data),
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    color: ConstColor.blackColor),
                iOS: const DarwinNotificationDetails()),
          );
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      dataFromNotification = message!.data;
      _handleNavigationOnNotificationClick();
    });
  }
  // navigateFromNotification() {
  //   notificationCallBackStream.sink.add(true);
  // }

  void _handleNavigationOnNotificationClick() async {

    //   if (Platform.isIOS) {
    //     setCurrentScreenName(screenName: ConstString.notificatiOpen);
    //   }
    //   setCurrentScreenName(screenName: ConstString.notificationClick);
    //   final prefs = await SharedPreferences.getInstance();
    //   if (prefs.getString('token') != null) {
    //     if (dataFromNotification['notification_type'] == 1.toString()) {
    //       Future.delayed(
    //         const Duration(seconds: 2),
    //         () {
    //           navigateFromNotification();
    //           Get.offAll(const ChatdetailsSecondView(), arguments: {
    //             "from": "1",
    //             "chat_room_id": dataFromNotification['chat_room_id'].toString(),
    //           });
    //         },
    //       );
    //     } else if (dataFromNotification['notification_type'] == 2.toString()) {
    //       Future.delayed(
    //         const Duration(seconds: 2),
    //         () {
    //           navigateFromNotification();
    //           Get.offAll(const EmptylegflightsView(), arguments: {
    //             "from": dataFromNotification['flight_request_id'].toString(),
    //             "notification_id":
    //                 dataFromNotification['notification_id'].toString(),
    //           });
    //         },
    //       );
    //     } else if (dataFromNotification['notification_type'] == 3.toString()) {
    //       Future.delayed(
    //         const Duration(seconds: 2),
    //         () {
    //           navigateFromNotification();
    //           Get.offAll(const FlightDetailsView(), arguments: {
    //             "from": dataFromNotification['flight_request_id'].toString(),
    //             "notification_id":
    //                 dataFromNotification['notification_id'].toString(),
    //           });
    //         },
    //       );
    //     } else if (dataFromNotification['notification_type'] == 4.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const FlightDetailsView(), arguments: {
    //           "from": dataFromNotification['flight_request_id'].toString(),
    //           "notification_id":
    //               dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else if (dataFromNotification['notification_type'] == 5.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const FlightDetailsView(), arguments: {
    //           "from": dataFromNotification['flight_request_id'].toString(),
    //           "notification_id":
    //               dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else if (dataFromNotification['notification_type'] == 6.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const FlightDetailsView(), arguments: {
    //           "from": dataFromNotification['flight_request_id'].toString(),
    //           "notification_id":
    //               dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else if (dataFromNotification['notification_type'] == 7.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const FlightDetailsView(), arguments: {
    //           "from": dataFromNotification['flight_request_id'].toString(),
    //           "notification_id":
    //               dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else if (dataFromNotification['notification_type'] == 8.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const FlightDetailsView(), arguments: {
    //           "from": dataFromNotification['flight_request_id'].toString(),
    //           "notification_id":
    //               dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else if (dataFromNotification['notification_type'] == 9.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(
    //           const BottomBarView(),
    //         );
    //       });
    //     } else if (dataFromNotification['notification_type'] == 10.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const BottomBarView(), arguments: {
    //           "notification_id":
    //               dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else if (dataFromNotification['notification_type'] == 11.toString()) {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(const BottomBarView(), arguments: {
    //           "member": dataFromNotification['notification_id'].toString(),
    //         });
    //       });
    //     } else {
    //       Future.delayed(const Duration(seconds: 2), () {
    //         navigateFromNotification();
    //         Get.offAll(
    //           const BottomBarView(),
    //         );
    //       });
    //     }
    //   } else {}
  }
}
