import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // To manage loading state

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _handleLogin() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
    } else if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address")),
      );
    } else {
      setState(() {
        _isLoading = true;
      });

      // Simulate a login process
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacementNamed(context, '/home'); // Navigate to home page
        }
      });
    }
  }

  void _handleAnonymousLogin() {
    Navigator.pushReplacementNamed(context, '/home'); // Skip login, go to home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E9F1),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.pink.shade200,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back to previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login to HerVoice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: Icon(Icons.email, color: Colors.pink.shade200),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: Icon(Icons.lock, color: Colors.pink.shade200),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            _isLoading
                ? const Center(child: CircularProgressIndicator()) // Loading indicator while processing
                : Column(
              children: [
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),

                // ✅ New "Login" button for verification
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/verification');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade800, // A slightly different pink for variation
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Login', style: TextStyle(color: Colors.white)),
                ),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: _handleAnonymousLogin,
                  child: Text('Continue Anonymously', style: TextStyle(color: Colors.pink.shade200)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
