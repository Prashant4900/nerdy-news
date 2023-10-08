import 'package:flutter/material.dart';

class MyErrorScreen extends StatelessWidget {
  const MyErrorScreen({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('data')),
    );
  }
}
