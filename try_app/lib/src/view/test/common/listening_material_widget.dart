import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ListeningMaterialWidget extends StatefulWidget {
  final String content;
  final VoidCallback onNext;

  const ListeningMaterialWidget(
      {super.key, required this.content, required this.onNext});

  @override
  ListeningMaterialWidgetState createState() => ListeningMaterialWidgetState();
}

class ListeningMaterialWidgetState extends State<ListeningMaterialWidget> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((event) {
      widget.onNext();
    });
    _playLocalAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playLocalAudio() async {
    const audioFilePath = 'assets/deepgram-asteria-1717651025257.mp3';
    setState(() {
      _isPlaying = true;
    });
    await _audioPlayer.play(AssetSource(audioFilePath));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          // widget.content,
          "Reliability vs Features",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset('assets/images/test.png'),
        const SizedBox(height: 20),
        // _isPlaying
        //     ? CircularProgressIndicator()
        //     : ElevatedButton(
        //         onPressed: _playLocalAudio,
        //         child: const Text("Replay Audio"),
        //       ),
      ],
    );
  }
}
