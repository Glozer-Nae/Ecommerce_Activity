import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onFavorite,
    this.onAddToCart,
    });


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Align(
             alignment: Alignment.topRight,
             child: IconButton(
              onPressed: onFavorite, 
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              ),
            ),

            Expanded(child: Image.asset(product.image)),
            Text(
              product.weapon,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(product.status),
            Text("\$${product.price}"),
            
            if (onAddToCart != null)
              ElevatedButton(
                onPressed: onAddToCart,
                child: const Text('Add to Cart'),
              ),
          ]),
        ),
    );
  }
}