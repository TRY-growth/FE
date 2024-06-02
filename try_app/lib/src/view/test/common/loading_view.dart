import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(BuildContext, dynamic) nextWidget;

  const LoadingView({
    super.key,
    required this.future,
    required this.nextWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text("Loading")),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => nextWidget(context, snapshot.data),
            ));
          });
          return Container(); // Empty container while waiting for navigation
        }
      },
    );
  }
}
