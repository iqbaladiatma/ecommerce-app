import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/cart_provider.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({super.key});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Nike Air Max',
      'description': 'Running shoes with Air cushioning',
      'price': '\$129.99',
      'discount': '20%',
      'image': 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      'rating': 4.5,
      'isFavorite': false,
    },
    {
      'name': 'Adidas Ultraboost',
      'description': 'Responsive running shoes',
      'price': '\$179.99',
      'discount': '15%',
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      'rating': 4.7,
      'isFavorite': true,
    },
    {
      'name': 'Puma RS-X',
      'description': 'Retro running sneakers',
      'price': '\$109.99',
      'discount': '10%',
      'image': 'https://images.unsplash.com/photo-1595341888016-a392ef81b7de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      'rating': 4.3,
      'isFavorite': false,
    },
    {
      'name': 'Nike React',
      'description': 'Lightweight running shoes',
      'price': '\$149.99',
      'discount': '25%',
      'image': 'https://images.unsplash.com/photo-1605408499393-79165b7e0e0f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80',
      'rating': 4.8,
      'isFavorite': true,
    },
  ];

  // Toggle favorite status
  void _toggleFavorite(int index) {
    setState(() {
      products[index]['isFavorite'] = !products[index]['isFavorite'];
    });
  }

  // Add to cart function
  void _addToCart(BuildContext context, Map<String, dynamic> product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    
    // Show a snackbar when item is added to cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            // Remove the last added item if user undoes
            cartProvider.removeItem(product['name']);
          },
        ),
      ),
    );
    
    // Add item to cart
    final priceString = product['price'].replaceAll(RegExp(r'[^\d.]'), '');
    final price = double.tryParse(priceString) ?? 0.0;
    
    cartProvider.addItem(
      product['name'], // productId
      product['name'], // title
      price,           // price
      product['image'], // imageUrl
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
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
                      onPressed: () {
                        final index = products.indexOf(product);
                        if (index != -1) {
                          _toggleFavorite(index);
                        }
                      },
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
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF4C53A5),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
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
                    InkWell(
                      onTap: () => _addToCart(context, product),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C53A5),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ],
        );
      },
    );
  }
}
