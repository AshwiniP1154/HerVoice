import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencySOSScreen extends StatelessWidget {
  const EmergencySOSScreen({super.key});

  void _callEmergencyNumber() async {
    final Uri emergencyNumber = Uri.parse('tel:911');
    if (await canLaunchUrl(emergencyNumber)) {
      await launchUrl(emergencyNumber);
    } else {
      debugPrint("Could not launch emergency number");
    }
  }

  void _shareLocation() {
    // TODO: Implement location sharing functionality
  }

  void _alertContacts() {
    // TODO: Implement alert functionality
  }

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
        title: const Text(
          'Emergency SOS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onLongPress: _callEmergencyNumber,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.pink[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.emergency, color: Colors.white, size: 32),
                    SizedBox(height: 4),
                    Text(
                      'HOLD FOR SOS',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.call, 'Call Emergency', _callEmergencyNumber),
                _buildActionButton(Icons.notifications_active, 'Alert Contacts', _alertContacts),
                _buildActionButton(Icons.location_on, 'Share Location', _shareLocation),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.pink[100],
            child: Icon(icon, color: Colors.pink[800], size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
