import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E9F1), // Mauve Theme
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Resources",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _resourceCard(
              context,
              title: "Mental Health",
              description: "Guidance & support for mental well-being",
              imagePath: "assets/mental_health.jpg",
              route: "/mental_health_resources",
            ),
            _resourceCard(
              context,
              title: "Safety Tips",
              description: "Important tips to stay safe",
              imagePath: "assets/safety.jpg",
              route: "/safety_tips",
            ),
            _resourceCard(
              context,
              title: "Career Support",
              description: "Career advice and job resources",
              imagePath: "assets/career.jpg",
              route: "/career_support",
            ),
            _resourceCard(
              context,
              title: "Legal Rights",
              description: "Know your legal rights & laws",
              imagePath: "assets/legal.jpg",
              route: "/legal_rights",
            ),
          ],
        ),
      ),
    );
  }

  // **Reusable Resource Card Widget**
  Widget _resourceCard(
      BuildContext context, {
        required String title,
        required String description,
        required String imagePath,
        required String route,
      }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
            ),
          ),
          padding: const EdgeInsets.all(16),
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
