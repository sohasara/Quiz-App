import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.purple[300],
      ),
    );
  }
}
