import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item_samples.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final totalAmount = cartProvider.totalAmount;
    final itemCount = cartProvider.itemCount;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF4C53A5),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Cart Summary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFF4C53A5),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  '$itemCount ${itemCount <= 1 ? 'Barang' : 'Barang'}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    // Clear cart action
                    cartProvider.clearCart();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text('Hapus Semua'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // Cart Items
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: const CartItemSamples(),
              ),
            ),
          ),

          // Order Summary
          if (itemCount > 0) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                  bottom: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Column(
                children: [
                  // Voucher Input
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Masukkan kode voucher',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: const Color(
                              0xFF4C53A5,
                            ).withValues(alpha: 0.1),
                          ),
                          child: const Text(
                            'Pakai',
                            style: TextStyle(
                              color: Color(0xFF4C53A5),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Order Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal ($itemCount ${itemCount <= 1 ? 'barang' : 'barang'})',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        'Rp${totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ongkos Kirim',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        'Rp10.000',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp${(totalAmount + 10000).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Checkout Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle checkout
                  if (cartProvider.items.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Your cart is empty!')),
                    );
                    return;
                  }
                  // Navigate to checkout page
                  Navigator.pushNamed(context, '/checkout');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C53A5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Checkout Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
