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
  // Class properties (use final for StatelessWidget)
  final int stockQuantity;
  final String productName;
  final double productPrice;
  final String? imagePath; // Optional local asset image (for local images)
  final String? productDescription; // Optional description

  // Constructor with optional parameters for compatibility
  const ProductDetails({
    super.key,
    required this.stockQuantity,
    required this.productName,
    required this.productPrice,
    required this.imagePath,
    this.productDescription, // Defaults to null
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image (Local Asset)
            SizedBox(
              height: 100,
              child: Image.asset(
                imagePath ?? 'assets/protractor.png', // Always load the local image
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // Product Name
            Text(
              productName,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // Price
            Text(
              "\$${productPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
            ),

            // Stock Quantity
            Text(
              "Stock: ${stockQuantity.toString()}",
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),

            const SizedBox(height: 10),

            // Product Description (optional)
            if (productDescription != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  productDescription!,
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),

            const SizedBox(height: 20),

           /* // Buy Now Button
            ElevatedButton.icon(
              onPressed: stockQuantity > 0 ? () {} : null, // Disable if out of stock
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Buy Now"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                textStyle: const TextStyle(fontSize: 25),
              ),
            ),

           */
            const SizedBox(height: 10),

            // Back to Shop Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 3), // Adds a black border
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adds more padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Optional: Rounded corners
                  ),
                ),
                child: const Text(
                  "Back to Shop",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
