import 'package:flutter/material.dart';
import 'package:product_cart_app/models/product.dart';

class CartProvider extends ChangeNotifier{
  List<Product> cart = [];

  void addToCart(Product product){
    cart.add(product);
    notifyListeners();
  }
}