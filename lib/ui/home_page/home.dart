import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quiz_app/data/container_data.dart';
import 'package:quiz_app/ui/home_page/container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, Nadia ',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Let\'s make this day productive',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.person_2,
                    size: 50,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(width: 0.3),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Let\'s  Play',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 18,
                children: List.generate(
                  dataImage.length,
                  (index) {
                    return StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: ContainerBox(
                        index: index,
                        imageurl: dataImage[index]['imageurl'].toString(),
                        text: dataImage[index]['text'].toString(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}