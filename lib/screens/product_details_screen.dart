/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// ignore_for_file: must_be_immutable

// Program Imports
import 'package:flutter/material.dart';

// PRODUCT DETAILS SCREEN (Stateless)
class ProductDetails extends StatelessWidget {
  // Class properties
  int stockQuantity; // how much is left of this particular item in stock
  String productName; // name of the item
  double productPrice; // price of 1 of this item

  // Constructor
  ProductDetails(
      {super.key,
      required this.stockQuantity,
      required this.productName,
      required this.productPrice});

  /// Override the build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details") // app title
          ),
      body: Center(
        child: Padding(
            padding:
                const EdgeInsets.all(10), // padding for layout beautification
            child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // center screen elements horizontally
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 100,
                  ), // Icon to represent an item
                  Text(
                    productName,
                    style: const TextStyle(fontSize: 30),
                  ), // product name
                  Text(
                    "\$${productPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ), // formatted price
                  Text(
                    "Stock quantity: ${stockQuantity.toString()}",
                    style: const TextStyle(fontSize: 18),
                  ) // how much is left of this item in stock
                ])),
      ),
    );
  }
}
