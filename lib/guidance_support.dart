import 'package:flutter/material.dart';

class GuidanceSupportScreen extends StatelessWidget {
  const GuidanceSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.pink[300],
              child: const Text(
                'HV',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'HerVoice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 8),
            const Text(
              'Empowering Women Through Legal Support',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(Icons.gavel, 'Legal Consultation', 'Expert legal advice tailored for women'),
            _buildInfoCard(Icons.balance, "Women's Rights", 'Protecting and advocating for your rights'),
            _buildInfoCard(Icons.people, 'Support Network', 'Connect with a community of strong women'),
            const SizedBox(height: 20),
            const Text(
              'Creating a safer world for women',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.pinkAccent),
            ),
            const Icon(Icons.favorite, color: Colors.pinkAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.pinkAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        onTap: () {},
      ),
    );
  }
}
