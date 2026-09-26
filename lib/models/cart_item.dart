import 'package:product_cart_app/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product,  this.quantity = 1});

}