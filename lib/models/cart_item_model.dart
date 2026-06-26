import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  int get totalPrice => int.parse(product.price.replaceAll(',', '')) * quantity;
}
