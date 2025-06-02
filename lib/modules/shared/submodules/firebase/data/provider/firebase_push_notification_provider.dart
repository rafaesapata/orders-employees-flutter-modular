import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebasePushNotificationProvider {
  static const _androidChannhelId = 'androidChannelId';
  static const _androidChannhelName = 'androidChannelName';
  static const _androidChannelDescription = 'androidChannelDescription';
  static const _androidIcon = 'notification_icon';

  static final _instance = FirebasePushNotificationProvider._internal();
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'android_notification_channel',
    'Android Notifications',
    description: 'This channel is used for android notifications.',
    importance: Importance.max,
  );

  static late AndroidInitializationSettings _androidSettings;
  static late DarwinInitializationSettings _iOSSettings;

  FirebasePushNotificationProvider._internal();
  factory FirebasePushNotificationProvider() => _instance;

  Future<void> initialize() async {
    await _initializePlatforms();
    await _createService();

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    FirebaseMessaging.onMessage.listen(_showNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('Message clicked!: $message');
    });
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String> getPushToken() async =>
      await FirebaseMessaging.instance.getToken() ?? '';

  static Future<void> _createService() async =>
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidNotificationChannel);

  static Future<void> _initializePlatforms() async {
    _androidSettings = const AndroidInitializationSettings(_androidIcon);
    _iOSSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: _androidSettings, iOS: _iOSSettings),
    );
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    final hasData =
        message.data.containsKey('title') || message.data.containsKey('body');
    if (message.notification != null || hasData) {
      _showNotification(message);
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async =>
      await _flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.data['title'] ?? message.notification?.title ?? '',
        message.data['body'] ?? message.notification?.body ?? '',
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannhelId,
            _androidChannhelName,
            channelDescription: _androidChannelDescription,
            channelShowBadge: true,
            enableVibration: true,
            vibrationPattern: Int64List.fromList([0, 1000, 5000, 2000]),
            enableLights: true,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data['payload'] ?? '',
      );
}
