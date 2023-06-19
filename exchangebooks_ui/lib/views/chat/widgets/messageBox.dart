import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final String message;
  final Color color;
  const MessageBox({super.key, required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
