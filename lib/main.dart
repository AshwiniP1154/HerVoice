import 'package:flutter/material.dart';
import 'start.dart';
import 'login.dart';
import 'home.dart';
import 'chatbot.dart';
import 'community_forum.dart';
import 'guidance_support.dart';
import 'emergency_sos.dart';
import 'profile.dart';
import 'resources.dart';
import 'verification.dart'; // ✅ Added verification screen

void main() {
  runApp(const HerVoiceApp());
}

class HerVoiceApp extends StatelessWidget {
  const HerVoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HerVoice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        primaryColor: Colors.purple.shade200,
        scaffoldBackgroundColor: Colors.purple.shade50,
      ),
      initialRoute: '/start', // ✅ Change this to '/login' if needed
      routes: {
        '/start': (context) => const StartPage(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/community': (context) => const SocialFeedScreen(),
        '/guidance_support': (context) => const GuidanceSupportScreen(),
        '/sos': (context) => const EmergencySOSScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/verification': (context) => const VerificationScreen(), // ✅ Added verification route
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const StartPage()); // ✅ Default to StartPage instead of Home
      },
    );
  }
}
