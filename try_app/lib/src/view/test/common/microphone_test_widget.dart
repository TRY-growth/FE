import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MicrophoneTestWidget extends StatefulWidget {
  final VoidCallback onNext;

  const MicrophoneTestWidget({super.key, required this.onNext});

  @override
  MicrophoneTestWidgetState createState() => MicrophoneTestWidgetState();
}

class MicrophoneTestWidgetState extends State<MicrophoneTestWidget> {
  bool _microphoneAccessGranted = false;

  @override
  void initState() {
    super.initState();
    _checkMicrophonePermission();
  }

  Future<void> _checkMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    setState(() {
      _microphoneAccessGranted = status.isGranted;
    });
  }

  Future<void> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    setState(() {
      _microphoneAccessGranted = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Press the button below\nto allow microphone access,\nor\npress the next button\nto answer with text.",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Barlow',
            letterSpacing: 0.5,
            height: 1.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF210A3B),
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _requestMicrophonePermission,
          child: Icon(_microphoneAccessGranted ? Icons.mic : Icons.mic_off),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
