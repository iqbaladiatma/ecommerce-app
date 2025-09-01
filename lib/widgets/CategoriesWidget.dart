import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.sports_soccer, 'name': 'Soccer'},
    {'icon': Icons.directions_run, 'name': 'Running'},
    {'icon': Icons.sports_basketball, 'name': 'Basketball'},
    {'icon': Icons.fitness_center, 'name': 'Training'},
    {'icon': Icons.sports_tennis, 'name': 'Tennis'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C53A5).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    categories[index]['icon'],
                    size: 30,
                    color: const Color(0xFF4C53A5),
                  ),
                ),
                Text(
                  categories[index]['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
