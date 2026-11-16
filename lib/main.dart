import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vroute/pages/RegisterPage.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/about_agu_page.dart';
import 'pages/about_vroute_page.dart';
import 'pages/puzzles_page.dart';
import 'pages/facilities_page.dart';
import 'pages/ar_experience_page.dart';
import 'pages/weather_page.dart';
import 'pages/comments_page.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase başlatıldı

  // Bildirim izinlerini isteme işlemi
  await _requestNotificationPermission();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(VRouteApp());
}

// Bildirim izinlerini istemek için gerekli fonksiyon
Future<void> _requestNotificationPermission() async {
  final status = await Permission.notification.status;

  if (status.isDenied || status.isRestricted) {
    await Permission.notification.request();
  }
}

class VRouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VRoute',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // İlk rota LoginPage
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/aboutAGU': (context) => AboutAGUPage(),
        '/aboutVRoute': (context) => AboutVRoutePage(),
        '/puzzles': (context) => PuzzlesPage(),
        '/facilities': (context) => FacilitiesPage(),
        '/arExperience': (context) => ARExperiencePage(),
        '/weatherPage': (context) => WeatherPage(), //
        '/comments': (context) => CommentsPage(),
      },
    );
  }
}
