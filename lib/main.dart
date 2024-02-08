import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'views/preference_view.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';

void main() async {
  await dotenv.load(fileName: '.env');
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
        'preference': (context) => const PreferenceView(),
        //'home': (context) => HomeView(),
      },
    );
  }
}
