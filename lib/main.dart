import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/data_logs_screen.dart';
import 'screens/image_gen_screen.dart';
import 'screens/diagnostics_screen.dart';
import 'screens/persona_builder_screen.dart';
import 'screens/prompt_alchemist_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF6C63FF),
        scaffoldBackgroundColor: Color(0xFF0F0C29), 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white), // Forces back arrows to be white
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2), // Fixed black text!
        ),
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
        '/chat': (context) => ChatScreen(),
        '/data_logs': (context) => DataLogsScreen(),
        '/image_gen': (context) => ImageGenScreen(),
        '/diagnostics': (context) => DiagnosticsScreen(),
        '/persona': (context) => PersonaBuilderScreen(), // NEW
        '/alchemist': (context) => PromptAlchemistScreen(), // NEW
      },
    );
  }
}