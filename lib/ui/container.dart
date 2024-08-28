import 'package:flutter/material.dart';

class ContainerBox extends StatelessWidget {
  const ContainerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(width: 0.3),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Image.asset('assets/football.png'),
          const Text(
            'Sports',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.purple,
            ),
          ),
          const Text('10 Questions'),
        ],
      ),
    );
  }
}
