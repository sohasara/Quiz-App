import 'package:flutter/material.dart';
import 'package:quiz_app/ui/home_page/home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/brain.png',
              height: 130,
              width: 130,
              color: Colors.purple[700],
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Text(
                  'QUIZ',
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w700,
                    color: Colors.purple[600],
                  ),
                ),
                Image.asset(
                  'assets/auto.png',
                  width: 90,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            const SizedBox(
              height: 180,
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
                width: 320,
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
      ),
    );
  }
}
