import 'package:flutter/material.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple[100]!,
              Colors.purple[200]!,
              Colors.purple[100]!
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              width: 330,
              decoration: BoxDecoration(
                color: Colors.purple[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'what is the name of the capital of bangladesh?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              width: 245,
              height: 400,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Container(
                      height: 80,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
