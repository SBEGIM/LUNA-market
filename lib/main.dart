import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/config.dart';
import 'package:haji_market/src/core/utils/refined_logger.dart';
import 'package:haji_market/src/feature/app/presentation/my_app.dart';
import 'package:haji_market/src/feature/initialization/logic/composition_root.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.low,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> getDeviceToken() async {
  final box = GetStorage();
  final deviceToken = await FirebaseMessaging.instance.getToken();

  if (deviceToken != null) {
    await box.write('device_token', deviceToken.toString());
  }
}

// configs
const config = Config();

Future<void> main() async {
  try {
    // 👇 MUST be first line
    WidgetsFlutterBinding.ensureInitialized();

    // Now it's safe to call platform-channel APIs
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await GetStorage.init();
    await Firebase.initializeApp();

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
    const initializationSettingsIOs = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOs,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await getDeviceToken();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    if (kDebugMode) print(e);
  } finally {
    final result = await CompositionRoot(config, logger).compose();

    runApp(MyApp(result: result));
  }
}
