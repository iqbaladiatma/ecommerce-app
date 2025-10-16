import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.phone_android, 'name': 'HP'},
    {'icon': Icons.computer, 'name': 'Teknologi'},
    {'icon': Icons.weekend, 'name': 'Perabotan'},
    {'icon': Icons.restaurant, 'name': 'Makanan'},
    {'icon': Icons.sports_soccer, 'name': 'Olahraga'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 90,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      categories[index]['icon'],
                      size: 25,
                      color: const Color(0xFF4C53A5),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categories[index]['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4C53A5),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
