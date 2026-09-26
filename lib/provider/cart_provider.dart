import 'package:flutter/material.dart';
import 'package:product_cart_app/models/cart_item.dart';
import 'package:product_cart_app/models/product.dart';

class CartProvider extends ChangeNotifier{
  List<CartItem> cart = [];

  void addToCart(Product product){
    bool found = false;
    for(CartItem item in cart){
      if(item.product == product){
        found = true;
        item.quantity++;
      }
    }
    if(found == false){
      cart.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void increaseQuantity(CartItem item){
        item.quantity++;
        notifyListeners();
  }

  void decreaseQuantity(CartItem item){
    if(item.quantity > 1){
      item.quantity--;
    }
    notifyListeners();
  }

  void removeItem(CartItem item){
    cart.remove(item);
    notifyListeners();
  }

  double get subTotal{
    double total = 0;
    for(CartItem item in cart){
      total += item.product.price * item.quantity;
    }
    return total;
  }

  double get discount{
    if(subTotal > 2000){
      return subTotal * 0.10;
    }else{
      return 0;
    }

  }

  double get finalTotal {
    return subTotal - discount;
  }

  int get totalItems {
    int total = 0;

    for (CartItem item in cart) {
      total += item.quantity;
    }

    return total;
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

}