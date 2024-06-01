import 'package:flutter/material.dart';

class StatusText extends StatefulWidget {
  final String text;
  const StatusText({super.key, required this.text});

  @override
  State<StatusText> createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.text),
    );
  }
}
