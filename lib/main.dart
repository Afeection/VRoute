import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'theme/app_theme.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/main_shell.dart';
import 'pages/about_agu_page.dart';
import 'pages/about_vroute_page.dart';
import 'pages/puzzles_page.dart';
import 'pages/ar_experience_page.dart';
import 'pages/facility_detail_page.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final status = await Permission.notification.status;
  if (status.isDenied || status.isRestricted) {
    await Permission.notification.request();
  }

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
  );

  runApp(const VRouteApp());
}

class VRouteApp extends StatelessWidget {
  const VRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, mode, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VRoute',
        themeMode: mode,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        initialRoute: '/splash',
        routes: {
          '/splash':     (_) => const SplashPage(),
          '/login':      (_) => const LoginPage(),
          '/register':   (_) => const RegisterPage(),
          '/main':       (_) => const MainShell(),
          '/aboutAGU':   (_) => const AboutAGUPage(),
          '/aboutVRoute':(_) => const AboutVRoutePage(),
          '/arExperience':(_)=> const ARExperiencePage(),
          '/puzzles':    (_) => const PuzzlesPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/facilityDetail') {
            final facility = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => FacilityDetailPage(facility: facility),
            );
          }
          return null;
        },
      ),
    );
  }
}
