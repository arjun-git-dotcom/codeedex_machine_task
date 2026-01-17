import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/login/login_page.dart';
import 'modules/home/home_page.dart';

import 'services/api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()), 
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
