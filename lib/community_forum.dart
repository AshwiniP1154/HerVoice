import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HerVoice',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
        ),
        backgroundColor: Colors.purple.shade50,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings, color: Colors.purple),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _categoryButton('Trending', true),
                _categoryButton('Wellness', false),
                _categoryButton('Career', false),
                _categoryButton('Relationships', false),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _postCard('Sarah', '2 hours ago', 'Career Growth',
                    'Breaking the Glass Ceiling',
                    'Sharing my experience as a woman in tech and how I navigated challenges to reach a leadership position.',
                    234, 45, 12),
                _postCard('Shruti', '3 hours ago', 'Wellness',
                    'Self-Care Sunday Rituals',
                    "Let's discuss our favorite self-care practices and how they help maintain work-life balance.",
                    189, 56, 8),
                _postCard('Jessie', '4 hours ago', 'Relationships', '', '', 0, 0, 0),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _categoryButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple.shade300 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _postCard(String user, String time, String tag, String title,
      String description, int likes, int comments, int shares) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.purple),
                const SizedBox(width: 8),
                Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 6),
                Text(time, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
            if (tag.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(tag, style: TextStyle(color: Colors.purple)),
              ),
            ],
            if (title.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
            if (description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(description, style: TextStyle(color: Colors.black54)),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.favorite_border, likes),
                _iconText(Icons.comment, comments),
                _iconText(Icons.share, shares),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, int count) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text('$count', style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
