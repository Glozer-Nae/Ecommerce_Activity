import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final int totalAmount;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? address;
  String? cardNumber;

  void _processCheckout() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Order Placed Successfully!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $fullName'),
              const SizedBox(height: 8),
              Text('Email: $email'),
              const SizedBox(height: 8),
              Text('Total Amount: \$${widget.totalAmount}'),
              const SizedBox(height: 8),
              Text('Items: ${widget.cartItems.length}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to cart
                Navigator.of(context).pop(); // Go back to home
              },
              child: const Text('Thank you for your purchase!'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Summary',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      ...widget.cartItems.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${item.product.weapon} x${item.quantity}'),
                            Text('\$${item.totalPrice}'),
                          ],
                        ),
                      )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '\$${widget.totalAmount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Customer Information
              const Text(
                'Customer Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) => fullName = value,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } 
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
              ),
             
           
           
              // Place Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _processCheckout,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Place Order',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
