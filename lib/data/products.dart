import 'package:flutter/material.dart';
import 'package:product_cart_app/models/product.dart';

List<Product> products = [
  Product(name: 'T-Shirt', price: 800, icon: Icons.checkroom, category: 'Clothing'),
  Product(name: 'Shoes', price: 1500, icon: Icons.shopping_bag, category: 'Footwear'),
  Product(name: 'Watch', price: 1200, icon: Icons.watch, category: 'Accessories'),
  Product(name: 'Headphone', price: 1800, icon: Icons.headphones, category: 'Electronics'),
  Product(name: 'Backpack', price: 900, icon: Icons.backpack, category: 'Bags'),
  Product(name: 'Sunglasses', price: 700, icon: Icons.remove_red_eye, category: 'Accessories'),
];
List<String> categories = [
  'All',
  'Clothing',
  'Footwear',
  'Accessories',
  'Electronics',
  'Bags',
];