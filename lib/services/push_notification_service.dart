import 'package:application/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  initialization(BuildContext context) async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings settings =
        InitializationSettings(android: android, iOS: ios);
    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload != null) {
          context.push(details.payload!);
        }
      },
    );

    NotificationAppLaunchDetails? details =
        await _local.getNotificationAppLaunchDetails();
    if (details != null) {
      if (details.notificationResponse != null) {
        if (details.notificationResponse!.payload != null) {
          print('>>>>>${details.notificationResponse?.payload}');
        }
      }
    }
  }

  showNotification(String title, String reportId) async {
    NotificationDetails details = const NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: 0,
      ),
      android: AndroidNotificationDetails(
        "1",
        "test",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _local.show(
      1,
      title,
      "채점이 완료되었습니다.",
      details,
      payload: '/${RouterPath.report.name}/$reportId',
    );
  }
}
