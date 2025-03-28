import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // **Profile Picture with Shadow**
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile_placeholder.png'),
                ),
              ),
              const SizedBox(height: 15),

              // **User Info Card**
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      Text(
                        "Jane Doe",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "jane.doe@example.com",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // **Buttons Section**
              _buildProfileOption(icon: LucideIcons.pencil, text: "Edit Profile", onTap: () {}),
              _buildProfileOption(icon: LucideIcons.lock, text: "Change Password", onTap: () {}),
              _buildProfileOption(icon: LucideIcons.helpCircle, text: "Help & Support", onTap: () {}),
              _buildProfileOption(icon: LucideIcons.logOut, text: "Logout", color: Colors.red, onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String text, required VoidCallback onTap, Color color = Colors.purple}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color, size: 28),
        title: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
