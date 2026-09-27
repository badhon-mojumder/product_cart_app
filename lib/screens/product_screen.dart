import 'package:flutter/material.dart';
import 'package:product_cart_app/models/product.dart';
import 'package:product_cart_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../data/products.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Products',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),

          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              return Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(cartProvider.totalItems.toString()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          context.read<CartProvider>().searchProduct(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search product',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: cartProvider.selectedCategory,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                        underline: SizedBox(),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<CartProvider>().selectCategory(value);
                          }
                        },
                      ),
                    )
                  ],
                )
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.80,
                  ),
                  itemCount: cartProvider.filteredProducts.length,
                  itemBuilder: (context, index) {
                    Product product = cartProvider.filteredProducts[index];
                    return Card(
                      child: Column(
                        children: [
                          Icon(product.icon, size: 130),
                          SizedBox(height: 5),
                          Text(
                            product.name,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            product.price.toString(),
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(5),
                              ),
                            ),
                            onPressed: () {
                              context.read<CartProvider>().addToCart(product);
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
