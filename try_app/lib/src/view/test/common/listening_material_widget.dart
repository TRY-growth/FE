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
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
      widget.onNext();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playLocalAudio() async {
    if (isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    } else {
      String audioFilePath = '${widget.content}.mp3';
      await _audioPlayer.play(AssetSource(audioFilePath));
      setState(() {
        isPlaying = true;
      });
    }
  }

  String getDescription(String content) {
    switch (content) {
      case "2":
        return "Now listen to\na conversation\nbetween two students.";
      case "3":
        return "Now listen to\npart of a lecture on the topic\nin a psychology class.";
      case "4":
        return "Listen to\npart of a lecture\nin a business class.";
      default:
        return "Content not found.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          getDescription(widget.content),
          style: const TextStyle(
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
        const SizedBox(height: 20),
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 30,
            ),
            onPressed: _playLocalAudio,
          ),
        ),
      ],
    );
  }
}
