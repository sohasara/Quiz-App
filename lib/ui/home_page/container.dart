import 'package:flutter/material.dart';
import 'package:quiz_app/ui/details/sports.dart';

class ContainerBox extends StatelessWidget {
  final String imageurl;
  final String text;
  final int index;
  const ContainerBox({
    super.key,
    required this.imageurl,
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    double height = 230;
    if (index == 0) {
      height = 200;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SportsPage()));
      },
      child: Container(
        height: height,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 0.3),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Image.asset(
              imageurl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.purple,
              ),
            ),
            const Text(
              '10 Questions',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}