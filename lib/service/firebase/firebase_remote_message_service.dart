// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../utils/logger.dart';
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
//
// class FirebaseRemoteMessageService {
//   static final flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static const distanceTimeUpdateFcmToken = 30; // day
//
//   static const _androidNotificationDetails = AndroidNotificationDetails(
//     'channelId',
//     "channelName",
//     channelDescription: "channelDescription",
//     playSound: true,
//     priority: Priority.high,
//     importance: Importance.high,
//   );
//
//   static const _iosNotificationDetails = DarwinNotificationDetails(
//     threadIdentifier: 'thread_id',
//   );
//
//   static void _handleNotificationAction(Map<String, dynamic> data) {
//     try {
//       final id = data['notification_id'];
//       if (id != null) {
//
//         _navigateToDetailNotification(int.parse(id));
//       }
//     } catch (_) {}
//   }
//
//   static void _navigateToDetailNotification(int id) {
//
//   }
//
//   Future<void> setupFireBase() async {
//     try {
//       await Firebase.initializeApp();
//       final messaging = FirebaseMessaging.instance;
//
//       await _requestPermissionIfNeeded(messaging);
//       _updateFcmTokenOnServerIfNeeded();
//       _listenFcmNotification();
//       final tokenFcm = await messaging.getToken();
//       //await SharedPreferencesHelper.setFcmToken(tokenFcm ?? "");
//       logger.d('FCM Token:$tokenFcm');
//       await _setupLocalNotification();
//     } catch (e) {
//       logger.e('Setup firebase error: $e');
//     }
//   }
//
//   void _listenFcmNotification() async {
//     if (Platform.isAndroid) {
//       listenerMessageOnBackground();
//     }
//
//     final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       try {
//         final id = initialMessage.data['notification_id'];
//
//       } catch (_) {}
//     }
//
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       _handleNotificationAction(event.data);
//     });
//
//     _listenerMessageOnForeground();
//   }
//
//   void _updateFcmTokenOnServerIfNeeded() async {
//     /*final preferencesRepository = await getIt.getAsync<PreferencesRepository>();
//     final timeUpdateToken =
//         await preferencesRepository.getTimeLastUpdateFcmToken();
//     if (timeUpdateToken == null ||
//         timeUpdateToken.difference(DateTime.now()).inDays >=
//             distanceTimeUpdateFcmToken) {
//       logger.d("start update fcm token on server side");
//       final fcmToken = await FirebaseMessaging.instance.getToken();
//       try {
//         final networkFactory = getIt.get<NetworkRepository>();
//         final param = ModeEndPointUrl.updateFcmToken.toMap;
//         param.addAll({'fcmToken': fcmToken});
//         final resultUpdate = await networkFactory.post(queryParameters: param);
//         if (resultUpdate.isSuccessCall ?? false) {
//           await preferencesRepository.setCurrentTimeUpdateFcmToken();
//         }
//       } catch (e) {
//         logger.d("call api update token error");
//       }
//     } else {
//       logger.d("no need update fcm token to server side");
//     }*/
//   }
//
//   void _onDidReceiveLocalNotification(
//     int id,
//     String? title,
//     String? body,
//     String? payload,
//   ) async {
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       const NotificationDetails(
//         android: _androidNotificationDetails,
//         iOS: _iosNotificationDetails,
//       ),
//       payload: jsonEncode(payload),
//     );
//   }
//
//   static _onDidReceiveNotificationResponse(NotificationResponse details) {
//     _handleNotificationAction(json.decode(details.payload ?? ''));
//   }
//
//   Future<void> _setupLocalNotification() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
//     );
//
//     final initializationSettings = InitializationSettings(
//       iOS: initializationSettingsDarwin,
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
//     );
//   }
//
//   void _listenerMessageOnForeground() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         showNotification(message);
//       }
//     });
//   }
//
//   static void listenerMessageOnBackground() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   Future<void> _requestPermissionIfNeeded(FirebaseMessaging messaging) async {
//     if (Platform.isAndroid) {
//       await flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//     } else if (Platform.isIOS) {
//       await messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     }
//   }
//
//   static Future<void> showNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     final data = message.data;
//     final title = data['title'] ?? notification?.title;
//     final body = data['body'] ?? notification?.body;
//     await flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       title,
//       body,
//       const NotificationDetails(
//         android: _androidNotificationDetails,
//         iOS: _iosNotificationDetails,
//       ),
//       payload: jsonEncode(data),
//     );
//   }
//
//   static Future<void> requestNotificationPermissionIfNeeded(
//       BuildContext context,
//       [bool shouldOpenSetting = false]) async {
//     const permission = Permission.notification;
//     final result = await permission.request();
//     switch (result) {
//       case PermissionStatus.granted:
//         break;
//       case PermissionStatus.permanentlyDenied:
//         if (shouldOpenSetting) {
//           showDialogPermanentlyDeniedPermissionNotification(context);
//         }
//         break;
//       case PermissionStatus.denied:
//         final result2 = await permission.request();
//         if (result2 == PermissionStatus.permanentlyDenied &&
//             shouldOpenSetting) {
//           showDialogPermanentlyDeniedPermissionNotification(context);
//         }
//         break;
//       default:
//     }
//   }
//
//   static Future<bool> getNotificationPermissionStatus() async {
//     const permission = Permission.notification;
//     final currentStatus = await permission.status;
//     if (currentStatus == PermissionStatus.granted) {
//       return true;
//     }
//     return false;
//   }
//
//   static void showDialogPermanentlyDeniedPermissionNotification(
//       BuildContext context) {
//     DialogBase.showDialogNavigateToSettingNotification(
//       context: context,
//       title: S.current.dialog_notification_permission_title,
//       message: S.current.dialog_notification_permission_message,
//       textCancel: S.current.dialog_notification_permission_button_cancel,
//       textOk: S.current.dialog_notification_permission_button_ok,
//       cancelAction: () async {
//         openAppSettingStreamController.sink.add(true);
//       },
//       okAction: () async {
//         openAppSettingStreamController.sink.add(false);
//         await openAppSettings();
//       },
//     );
//   }
// }
