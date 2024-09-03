import 'package:flutter/material.dart';
import 'package:quiz_app/ui/home_page/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Column(
        children: [
          const SizedBox(
            height: 220,
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
          const SizedBox(
            height: 190,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: Container(
              height: 65,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple,
              ),
              child: const Center(
                child: Text(
                  'Get Startd',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
