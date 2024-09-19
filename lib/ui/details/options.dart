import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  final String op;
  const Options({super.key, required this.op});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.purple[300],
      ),
      child: Center(
          child: Text(
        op,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
    );
  }
}
