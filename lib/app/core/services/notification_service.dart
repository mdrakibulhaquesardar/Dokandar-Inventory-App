import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Top-level background message handler for FCM
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase if not already done (handled automatically in most cases)
  debugPrint("Handling background FCM message: ${message.messageId}");
}

class NotificationService extends GetxService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static const String _fcmChannelId = 'fcm_channel';
  static const String _fcmChannelName = 'FCM Push Notifications';
  
  static const String _reminderChannelId = 'daily_reminder_channel';
  static const String _reminderChannelName = 'Daily Reminders';

  Future<NotificationService> init() async {
    // 1. Initialize Timezones (Required for local scheduling)
    tz.initializeTimeZones();
    _initLocalTimezone();

    // 2. Initialize Local Notifications
    await _initLocalNotifications();

    // 3. Initialize Firebase Cloud Messaging
    await _initFCM();

    // 4. Automatically Schedule Daily Reminder at 9:00 AM
    await scheduleDailyReminder(hour: 9, minute: 0);

    return this;
  }

  void _initLocalTimezone() {
    try {
      // Attempt to guess local timezone location name, fallback to Asia/Dhaka (+6)
      final String timeZoneName = DateTime.now().timeZoneName;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
      } catch (ex) {
        tz.setLocalLocation(tz.UTC);
      }
    }
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create high importance channel for Android (required to show foreground HUD)
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        
    if (androidImplementation != null) {
      await androidImplementation.createNotificationChannel(
        const AndroidNotificationChannel(
          _fcmChannelId,
          _fcmChannelName,
          description: 'This channel is used for interactive push notifications.',
          importance: Importance.max,
        ),
      );
      await androidImplementation.createNotificationChannel(
        const AndroidNotificationChannel(
          _reminderChannelId,
          _reminderChannelName,
          description: 'This channel is used for recurring daily offline reminders.',
          importance: Importance.high,
        ),
      );
    }
  }

  Future<void> _initFCM() async {
    // Request push notification permissions (FCM)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('User push notification grant status: ${settings.authorizationStatus}');

    // Retrieve and print FCM token for debugging / server integration
    try {
      String? token = await _fcm.getToken();
      debugPrint('==================================================');
      debugPrint('🔥 Firebase Cloud Messaging Registration Token:');
      debugPrint('$token');
      debugPrint('==================================================');
    } catch (e) {
      debugPrint('FCM Token generation failed: $e');
    }

    // Register Background Handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Received a foreground FCM message: ${message.messageId}');
      _showForegroundNotification(message);
    });

    // Handle App Opened via Notification from Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('App opened via FCM notification: ${message.notification?.title}');
      _handleNotificationPayload(message.data);
    });

    // Handle App Opened via Notification from fully Terminated state
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('App launched from terminated state via FCM: ${initialMessage.notification?.title}');
      _handleNotificationPayload(initialMessage.data);
    }
  }

  void _showForegroundNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _fcmChannelId,
            _fcmChannelName,
            channelDescription: 'Foreground Firebase Push Notification channel',
            importance: Importance.max,
            priority: Priority.high,
            icon: android?.smallIcon ?? '@mipmap/launcher_icon',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  void _onLocalNotificationTap(NotificationResponse response) {
    debugPrint('Local notification tapped with payload: ${response.payload}');
  }

  void _handleNotificationPayload(Map<String, dynamic> data) {
    // Implement custom page redirection logic using Get.toNamed() if required
    debugPrint('Processing notification data payload: $data');
  }

  /// Schedule a local offline recurring notification at a specific time daily
  Future<void> scheduleDailyReminder({required int hour, required int minute}) async {
    // Unique Notification ID for daily reminder
    const int reminderNotificationId = 999;

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // If scheduled time has already passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    debugPrint('Scheduling recurring Daily Reminder to start at: $scheduledDate');

    await _localNotifications.zonedSchedule(
      id: reminderNotificationId,
      title: '📝 Dokandar Daily Reminder',
      body: "Don't forget to record today's sales and check your inventory levels!",
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _reminderChannelId,
          _reminderChannelName,
          channelDescription: 'Channel for recurring daily reminders',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // Enforces local daily repetition!
    );
  }

  /// Request runtime POST_NOTIFICATIONS permission on Android 13+
  Future<bool> requestAndroidNotificationPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      final bool? granted = await androidImplementation.requestNotificationsPermission();
      return granted ?? false;
    }
    return false;
  }

  /// Cancel all active scheduled reminders/notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
    debugPrint('All active notifications cancelled.');
  }
}
