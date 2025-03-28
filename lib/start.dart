import 'package:flutter/material.dart';
import 'dart:async';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => StartPageState();
}

class StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Timer _timer;  // Explicit Timer variable for cancellation

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    _timer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login'); // Ensure this route exists
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();  // Cancel the timer to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E9F1), // Mauve background
      body: Center( // Ensures everything is centered
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Aligns content properly
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade200, Colors.pink.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "HV",
                  style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "HerVoice",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pink),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your safe space to connect & empower",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 60,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.pink,
                  minHeight: 3,
                ),
              ),
              const SizedBox(height: 20), // Increased space for better readability
              const Text(
                "Creating your experience...",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30), // Extra spacing before button

              // Get Started Button (NEW)
              ElevatedButton(
                onPressed: () {
                  _timer.cancel(); // Cancel auto-navigation timer
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[800], // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
