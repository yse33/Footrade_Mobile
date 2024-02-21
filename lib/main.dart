import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'services/notification_service.dart';

import 'views/preference_view.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';

import 'dependency_injection/dependency_injection.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(NotificationService.firebaseBackgroundMessage);

  DependencyInjection.setup();

  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Footrade',
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginView(),
        'register': (context) => RegisterView(),
        'home': (context) => HomeView(),
        'preference': (context) => const PreferenceView(),
      },
    );
  }
}
