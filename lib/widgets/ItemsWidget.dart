import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      'name': 'Nike Air Max',
      'description': 'Running shoes with Air cushioning',
      'price': '\$129.99',
      'discount': '20%',
      'image': 'assets/images/1.png',
      'rating': 4.5,
      'isFavorite': false,
    },
    {
      'name': 'Adidas Ultraboost',
      'description': 'Responsive running shoes',
      'price': '\$179.99',
      'discount': '15%',
      'image': 'assets/images/2.png',
      'rating': 4.7,
      'isFavorite': true,
    },
    {
      'name': 'Puma RS-X',
      'description': 'Retro running sneakers',
      'price': '\$109.99',
      'discount': '10%',
      'image': 'assets/images/3.png',
      'rating': 4.3,
      'isFavorite': false,
    },
    {
      'name': 'Nike React',
      'description': 'Lightweight running shoes',
      'price': '\$149.99',
      'discount': '25%',
      'image': 'assets/images/4.png',
      'rating': 4.8,
      'isFavorite': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      crossAxisCount: 2,
      childAspectRatio: 0.72,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (var product in products)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Discount Badge and Favorite Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Discount Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        product['discount'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Favorite Button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        product['isFavorite']
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product['isFavorite']
                            ? Colors.red
                            : const Color(0xFF4C53A5),
                      ),
                    ),
                  ],
                ),

                // Product Image
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      product['image'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Product Name
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),

                // Product Description
                Text(
                  product['description'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const Spacer(),

                // Price and Add to Cart Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['price'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4C53A5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
