import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmate/main/my_app.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/routing/app_routing.dart';
import 'package:workmate/utils/toast_helper.dart';

import '../../main/main_dev.dart';
import '../../ui/events/page/add_event_page.dart';
import '../../utils/logger.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print("dongnd1 here: 1 $notificationResponse");
  try {
    final eventId = json.decode(notificationResponse.payload!)['event_id'];
    navigateToDetailNotification(eventId);
    print("dongnd1");
  } catch (e) {}
}

void navigateToDetailNotification(eventId) {
  final context = navigatorKey.currentContext;
  if (context != null) {
    if (isAddEventPage) {
      Navigator.of(context).popAndPushNamed(RouteDefine.addEvent.name,
          arguments:
          AddEventPageArgs(eventId: eventId, dateTime: DateTime.now()));
    } else {
      Navigator.of(context).pushNamed(RouteDefine.addEvent.name,
          arguments:
          AddEventPageArgs(eventId: eventId, dateTime: DateTime.now()));
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class FirebaseRemoteMessageService {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const distanceTimeUpdateFcmToken = 30; // day

  static const _androidNotificationDetails = AndroidNotificationDetails(
    'channelId',
    "channelName",
    channelDescription: "channelDescription",
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  static const _iosNotificationDetails = DarwinNotificationDetails(
    threadIdentifier: 'thread_id',
  );

  static void _handleNotificationAction(Map<String, dynamic> data) {
    try {
      final eventId = data['event_id'];
      if (eventId != null) {
        navigateToDetailNotification(eventId);
      }
    } catch (e) {
      ToastHelper.showToast("error when tap noti: $e");
    }
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  static void navigateToDetailNotification(String eventId) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      if (isAddEventPage) {
        Navigator.of(context).popAndPushNamed(RouteDefine.addEvent.name,
            arguments:
                AddEventPageArgs(eventId: eventId, dateTime: DateTime.now()));
      } else {
        Navigator.of(context).pushNamed(RouteDefine.addEvent.name,
            arguments:
                AddEventPageArgs(eventId: eventId, dateTime: DateTime.now()));
      }
    }
  }

  Future<void> setupFireBase() async {
    try {
      final messaging = FirebaseMessaging.instance;

      await _requestPermissionIfNeeded(messaging);
      await _configureLocalTimeZone();
      _listenFcmNotification();
      final tokenFcm = await messaging.getToken();
      //await SharedPreferencesHelper.setFcmToken(tokenFcm ?? "");
      _updateFcmTokenOnServerIfNeeded(tokenFcm);
      logger.d('FCM Token:$tokenFcm');
      await _setupLocalNotification();
    } catch (e) {
      logger.e('Setup firebase error: $e');
    }
  }

  static tz.TZDateTime convertTime(DateTime dateTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  void _listenFcmNotification() async {
    if (Platform.isAndroid) {
      listenerMessageOnBackground();
    }

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      try {
        final id = initialMessage.data['notification_id'];
      } catch (_) {}
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleNotificationAction(event.data);
    });

    _listenerMessageOnForeground();
  }

  void _updateFcmTokenOnServerIfNeeded(String? fcmToken) async {
    final uuid = FirebaseAuth.instance.currentUser?.uid;
    if (uuid != null &&
        (uuid.isNotEmpty) &&
        fcmToken != null &&
        fcmToken.isNotEmpty) {
      await FireStoreRepository().updateFcmTokenForUser(uuid, fcmToken);
    }
  }

  Future<void> updateFcmTokenOnServerAfterLoginOrRegister(String uuid) async {
    try {
      final messaging = FirebaseMessaging.instance;

      final tokenFcm = await messaging.getToken();
      if (tokenFcm != null && tokenFcm.isNotEmpty) {
        await FireStoreRepository().updateFcmTokenForUser(uuid, tokenFcm);
      }
    } catch (e) {
      logger.e('Error _updateFcmTokenOnServerAfterLoginOrRegister: $e');
    }
  }

  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: _androidNotificationDetails,
        iOS: _iosNotificationDetails,
      ),
      payload: jsonEncode(payload),
    );
  }

  static _onDidReceiveNotificationResponse(NotificationResponse details) {
    _handleNotificationAction(json.decode(details.payload ?? ''));
  }

  Future<void> _setupLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }



  void _listenerMessageOnForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });
  }

  static void listenerMessageOnBackground() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _requestPermissionIfNeeded(FirebaseMessaging messaging) async {
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    final data = message.data;
    final title = data['title'] ?? notification?.title;
    final body = data['body'] ?? notification?.body;
    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      title,
      body,
      const NotificationDetails(
        android: _androidNotificationDetails,
        iOS: _iosNotificationDetails,
      ),
      payload: jsonEncode(data),
    );
  }

  static void cancelNotificationSchedule(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime dateTime,
  ) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId',
      "channelName",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      channelDescription: "channelDescription",
    );
    print("dongnd1 schedule with time: ${dateTime}");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'title',
      'body',
      convertTime(dateTime),
      const NotificationDetails(
          android: androidNotificationDetails, iOS: _iosNotificationDetails),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '$id',
    );
  }

  static Future<void> requestNotificationPermissionIfNeeded(
      BuildContext context,
      [bool shouldOpenSetting = false]) async {
    const permission = Permission.notification;
    final result = await permission.request();
    switch (result) {
      case PermissionStatus.granted:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.denied:
        final result2 = await permission.request();
        break;
      default:
    }
  }

  static Future<bool> getNotificationPermissionStatus() async {
    const permission = Permission.notification;
    final currentStatus = await permission.status;
    if (currentStatus == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  static Future<bool> callOnFcmApiSendPushNotifications(
      List<String> userToken, String title, String body, String eventId) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "registration_ids": userToken,
      "collapse_key": "type_a",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "event_id": eventId,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAKc_pJ7U:APA91bE2KO2YFth3688hynca3X6sKZdh4Z9g-3XF-ghHZbpH-AtMFMixI682tMejEpMwluMJjAGeltcZk8NT9ZHCEUaaDAYI8GkcOtlEQcE32w5yNGbdUSFHFfE68D0rb0Vsx_ycjOzj'
      // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }
}
