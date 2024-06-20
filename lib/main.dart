import 'package:application/globals.dart';
import 'package:application/models/db/app_database.dart';
import 'package:application/router.dart';
import 'package:application/services/firebase.dart';
import 'package:application/services/push_notification_service.dart';
import 'package:application/styles/color_styles.dart';
import 'package:application/styles/text_styles.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late final AppDatabase database;
final FireBaseService fbService = FireBaseService();
final PushNotificationService pnService = PushNotificationService();

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  print(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await fbService.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

  goRouter.goNamed(RouterPath.home.name);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        useMaterial3: true,
        canvasColor: Colors.transparent,
        fontFamily: 'NanumBarunGothic',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
        ),
        colorScheme: const ColorScheme(
          primary: ColorStyles.primary,
          onPrimary: Colors.white,
          background: ColorStyles.background,
          onBackground: Colors.black,
          brightness: Brightness.light,
          secondary: ColorStyles.background,
          onSecondary: Colors.black,
          error: ColorStyles.primary,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          outlineVariant: Color(0xFFCAC4D0),
        ),
        iconTheme: const IconThemeData(color: ColorStyles.primary),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            surfaceTintColor: Colors.transparent,
            foregroundColor: ColorStyles.primary,
          ),
        ),
        chipTheme: const ChipThemeData(
          selectedColor: ColorStyles.primary,
          side: BorderSide.none,
          showCheckmark: false,
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.transparent,
        ),
        dialogBackgroundColor: Colors.transparent,
        listTileTheme: ListTileThemeData(
          visualDensity: const VisualDensity(vertical: -3, horizontal: 3),
          dense: true,
          minLeadingWidth: 150,
          leadingAndTrailingTextStyle: TextStyles.bodyMedium.copyWith(
            color: Colors.black,
          ),
          iconColor: Colors.black,
        ),
        popupMenuTheme: PopupMenuThemeData(
          position: PopupMenuPosition.under,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      color: ColorStyles.primary,
      routerConfig: goRouter,
    );
  }
}
