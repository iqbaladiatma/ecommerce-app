import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'cart_item_card.dart';

class CartItemSamples extends StatelessWidget {
  const CartItemSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    if (cartItems.isEmpty) {
      return _buildEmptyCart(context);
    }

    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (ctx, index) {
        final item = cartItems[index];
        return CartItemCard(
          productId: item.productId,
          title: item.title,
          price: item.price,
          imageUrl: item.imageUrl,
          quantity: item.quantity,
        );
      },
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Keranjang Kamu Kosong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ayo mulai belanja!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4C53A5),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Jelajahi Produk',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}