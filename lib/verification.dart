import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _selectedFileName;
  bool _isLoading = false; // Loading state for better UX

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if (result != null) {
      int fileSize = result.files.single.size; // Get file size in bytes
      double fileSizeMB = fileSize / (1024 * 1024); // Convert to MB

      if (fileSizeMB > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File too large. Max size: 5MB")),
        );
      } else {
        setState(() {
          _selectedFileName = result.files.single.name.length > 20
              ? result.files.single.name.substring(0, 17) + "..." // Truncate long names
              : result.files.single.name;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("File selected successfully!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File selection canceled.")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _skipVerification() {
    Future.microtask(() => Navigator.pushReplacementNamed(context, '/home'));
  }

  void _continueVerification() {
    if (_selectedFileName != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload a file or skip verification.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Government ID Verification'),
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please upload a valid government ID to verify your identity',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      if (_isLoading)
                        const CircularProgressIndicator(color: Colors.purple)
                      else
                        const Icon(Icons.cloud_upload, size: 50, color: Colors.purple),
                      const SizedBox(height: 10),
                      Text(
                        _selectedFileName ?? 'Tap to upload your ID',
                        style: const TextStyle(fontSize: 16, color: Colors.purple),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Supported formats: JPG, PNG, PDF (Max: 5MB)',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    'Your ID will be securely processed',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _continueVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade300,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Verify & Continue',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _skipVerification,
                child: const Text(
                  'Skip Verification',
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'By continuing, you agree to our Terms and Privacy Policy',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
