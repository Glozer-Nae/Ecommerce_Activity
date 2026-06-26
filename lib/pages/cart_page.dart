import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final ValueChanged<List<CartItem>> onCartUpdated;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onCartUpdated,
  });

  int get totalAmount {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Add items to get started',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Image.asset(
                        cartItem.product.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.product.weapon,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${cartItem.product.price}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (cartItem.quantity > 1) {
                                      cartItem.quantity--;
                                    } else {
                                      cartItems.removeAt(index);
                                    }
                                    onCartUpdated(List.from(cartItems));
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                  iconSize: 20,
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cartItem.quantity++;
                                    onCartUpdated(List.from(cartItems));
                                  },
                                  icon: const Icon(Icons.add_circle),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${cartItem.totalPrice}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          IconButton(
                            onPressed: () {
                              cartItems.removeAt(index);
                              onCartUpdated(List.from(cartItems));
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$$totalAmount',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          cartItems: cartItems,
                          totalAmount: totalAmount,
                        ),
                      ),
                    );
                  },
                  child: const Text('Proceed to Checkout'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
