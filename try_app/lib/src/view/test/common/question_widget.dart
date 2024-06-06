import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final void Function(String) onSubmit;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.onSubmit,
  });

  @override
  QuestionWidgetState createState() => QuestionWidgetState();
}

class QuestionWidgetState extends State<QuestionWidget> {
  final TextEditingController _controller = TextEditingController();
  final RecorderStream _recorder = RecorderStream();
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;
  bool _isRecording = false;
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    _recorder.initialize();
  }

  Future<void> _startListening() async {
    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });

    await _recorder.start();
    setState(() {
      _isRecording = true;
    });

    final serverUrl = dotenv.env['DEEPGRAM_SERVER_URL']!;
    final apiKey = dotenv.env['DEEPGRAM_API_KEY']!;

    channel = IOWebSocketChannel.connect(Uri.parse(serverUrl),
        headers: {'Authorization': 'Token $apiKey'});

    channel.stream.listen((event) async {
      final parsedJson = jsonDecode(event);
      final currentText =
          parsedJson['channel']['alternatives'][0]['transcript'];

      if (parsedJson['is_final']) {
        setState(() {
          _controller.text += currentText + " ";
        });
      } else {
        setState(() {
          _controller.text = _controller.text + currentText;
        });
      }
    });

    _audioStreamSubscription = _recorder.audioStream.listen((data) {
      channel.sink.add(data);
    });
  }

  Future<void> _stopListening() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    channel.sink.close();
    setState(() {
      _isRecording = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isRecording ? _stopListening : _startListening,
          child: Icon(_isRecording ? Icons.mic : Icons.mic_none),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _controller,
          maxLines: null,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Your response',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(_controller.text);
          },
          child: const Text("Submit Answer"),
        ),
      ],
    );
  }
}
