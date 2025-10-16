import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../providers/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;

  const CartItemCard({
    super.key,
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );

    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.red, size: 28),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Hapus Item'),
            content: const Text('Apakah Anda yakin ingin menghapus item ini dari keranjang?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('BATAL'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('HAPUS', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ?? false;
      },
      onDismissed: (direction) {
        cart.removeItem(productId);
        _showSnackBarWithUndo(
          context,
          'Item dihapus dari keranjang',
          () => cart.addItem(
            productId,
            title,
            price,
            imageUrl,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error_outline, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Iqbal Store',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currencyFormat.format(price),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Quantity Controls
                    Row(
                      children: [
                        // Decrease Quantity
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, size: 16),
                            padding: const EdgeInsets.all(2),
                            constraints: const BoxConstraints(),
                            onPressed: quantity <= 1
                                ? null
                                : () => cart.decreaseQuantity(productId),
                          ),
                        ),
                        // Quantity Display
                        Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text(
                            '$quantity',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        // Increase Quantity
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, size: 16),
                            padding: const EdgeInsets.all(2),
                            constraints: const BoxConstraints(),
                            onPressed: () => cart.increaseQuantity(productId),
                          ),
                        ),
                        const Spacer(),
                        // Remove Button
                        TextButton(
                          onPressed: () {
                            cart.removeItem(productId);
                            _showSnackBarWithUndo(
                              context,
                              'Item dihapus dari keranjang',
                              () => cart.addItem(
                                productId,
                                title,
                                price,
                                imageUrl,
                              ),
                            );
                          },
                          child: const Text(
                            'Hapus',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBarWithUndo(
      BuildContext context, String message, VoidCallback onUndo) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'BATALKAN',
        textColor: Colors.white,
        onPressed: () {
          onUndo();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: const Color(0xFF4C53A5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
