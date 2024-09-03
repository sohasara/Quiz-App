import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/auto.png',
                width: 90,
                fit: BoxFit.fitWidth,
              ),
              Text(
                'QUIZ',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w700,
                  color: Colors.purple[600],
                ),
              ),
              Image.asset(
                'assets/brain.png',
                // height: 150,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          Text('Get Startd'),
        ],
      ),
    );
  }
}
