import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4C53A5),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '🛒 My Cart',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 30),
            onSelected: (value) {
              // Handle menu item selection
              if (value == 'clear') {
                // Clear cart functionality would go here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clear cart functionality would go here')),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Clear Cart'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
