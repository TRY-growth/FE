import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedback = ModalRoute.of(context)?.settings.arguments;

    if (feedback != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamed('/feedback', arguments: feedback);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Loading"),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
