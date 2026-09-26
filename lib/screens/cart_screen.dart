import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart'), backgroundColor: Colors.blueAccent),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          if (cartProvider.cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your cart is empty', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Go to Products'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.cart.length,
                  itemBuilder: (context, index) {
                    CartItem item = cartProvider.cart[index];

                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(item.product.icon, size: 50),

                            SizedBox(width: 15),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text('৳${item.product.price}'),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cartProvider.decreaseQuantity(item);
                                        },
                                        icon: Icon(Icons.remove),
                                      ),

                                      Text(
                                        item.quantity.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          cartProvider.increaseQuantity(item);
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                cartProvider.removeItem(item);
                              },
                              child: Text('Remove'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Items'),
                        Text(cartProvider.totalItems.toString()),
                      ],
                    ),

                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal'),
                        Text('৳${cartProvider.subTotal.toStringAsFixed(2)}'),
                      ],
                    ),

                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount'),
                        Text('৳${cartProvider.discount.toStringAsFixed(2)}'),
                      ],
                    ),

                    SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Final Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '৳${cartProvider.finalTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          cartProvider.clearCart();
                        },
                        child: Text('Clear Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
