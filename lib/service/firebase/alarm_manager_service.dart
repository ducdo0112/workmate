import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmate/model/notification/notification_item.dart';
import 'package:workmate/model/user/user_info_data.dart';
import 'package:workmate/repository/firestore_repository.dart';
import 'package:workmate/service/firebase/firebase_remote_message_service.dart';
import 'package:workmate/utils/logger.dart';

@pragma('vm:entry-point')
void printHello(int id) async {
  try {
    await Firebase.initializeApp();
    NotificationItem notificationItem =
        await FireStoreRepository().findNotificationById(id);
    String? currentID = FirebaseAuth.instance.currentUser?.uid;
    if (currentID != null) {
      final listUserToSendMessage = notificationItem.users;
      if (listUserToSendMessage.isNotEmpty) {
        List<String> tokens = [];
        for (String uuid in listUserToSendMessage) {
          UserInfoData userInfoData =
              await FireStoreRepository().findUserByUid(uuid);
          if (userInfoData.fcmToken != null) {
            tokens.add(userInfoData.fcmToken!);
          }
        }
        if (tokens.isNotEmpty) {
          print("dongnd1 sendFCM: ${tokens.length} | ${tokens}, ${notificationItem.eventId}");
          FirebaseRemoteMessageService.callOnFcmApiSendPushNotifications(
            tokens,
            notificationItem.title,
            notificationItem.body,
            notificationItem.eventId,
          );
        }
      }
    }
  } catch (e) {
    logger.e("khong tìm thấy noti: $id, error: $e");
  }
}

class AlarmManagerService {
  static scheduleTaskForPushNotificationToOtherUser(
      DateTime dateTime,
      List<String> uuids,
      String title,
      String message,
      int id,
      String eventId) async {
    await FireStoreRepository()
        .addNotificationDateOnServer(id, title, message, uuids, eventId);
    AndroidAlarmManager.oneShotAt(
      dateTime,
      id,
      printHello,
      exact: true,
      wakeup: true,
      alarmClock: true,
      allowWhileIdle: true,
    );
  }

  static cancelScheduleTaskPushNotification(int id) async {
    final result = await AndroidAlarmManager.cancel(id);
    print("dongnd1 result cancel id $id: $result");
  }
}
