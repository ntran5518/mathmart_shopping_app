/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// ignore_for_file: must_be_immutable

// --- Program imports ---
// Packages
import 'package:flutter/material.dart';
// Screens
import 'catalog_screen.dart';
import 'customer_info_screen.dart';
// Classes
import '../classes/item.dart'; // Import Item class to create instances of a product of Absolute Value

// SHOPPING CART SCREEN
class ShoppingCartScreen extends StatefulWidget {
  List<Item> cartItems; // list of items customer has placed in cart

  // Constructor
  ShoppingCartScreen({super.key, required this.cartItems});

  @override
  ShoppingCartScreenState createState() {
    return ShoppingCartScreenState();
  }
}

// Shopping Cart Screen State
class ShoppingCartScreenState extends State<ShoppingCartScreen> {
  // store the TOTAL quantity & cost of all purchased items
  int totalItemQty = 0;
  double totalCost = 0;

  /// Override build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // app title
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, // Use a custom background color
      ),
      body: Container(
        padding: const EdgeInsets.all(16), // padding for layout beautification
        child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .center, // center screen elements horizontally
            children: [
              const Icon(
                Icons.shopping_cart_rounded,
                size: 100,
              ), // large cart icon
              Expanded(
                  // list of cart items
                  child: ListView.builder(
                itemCount:
                    cartItems.length, // get length of cart items from list
                itemBuilder: (context, index) {
                  if (cartItems.isEmpty) {
                    // if no items exist, output message
                    setState(() {
                      const Text(
                          "Empty Cart! Go to Catalog to purchase some items!");
                    });
                  }
                  // Loop through each stock item and find matching item to cart item's ID
                  int stockItemIndex = -1;
                  for (int i = 0; i < originalItemStockQuantities.length; i++) {
                    if (originalItemStock[i].id == cartItems[index].id) {
                      stockItemIndex = i; // store the index of that item
                    }
                  }

                  // Set the cart item's quantity to how much the user bought, not how much is in stock
                  cartItems[index].quantity =
                      originalItemStockQuantities[stockItemIndex] -
                          currentStatusItems[stockItemIndex].quantity;

                  // get the item associated with the current row
                  Item currItem = cartItems[index];

                  // Increment item quantities and prices for output
                  // totalItemQty += currItem.quantity;
                  totalCost += currItem.price * currItem.quantity;

                  // using the item, populate the row UI
                  return ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            currItem.imagePath, // ✅ Use imagePath from cartItems
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "ID: ${currItem.id}",
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    title: Text(currItem.name, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: Text("Price: \$${currItem.price.toStringAsFixed(2)}",style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                    trailing: Text(
                      "Purchased Quantity: ${currItem.quantity}",
                      style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              )),
              // check if cart is empty - if so, output message to go shopping!
              (cartItems.isEmpty)
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // center screen elements horizontally
                      children: [
                        Text(
                          "Empty Cart! Visit the catalog page to purchase some items! ",
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ), // message to display
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 70,
                        ), // empty cart image
                      ],
                    )
                  :
                  // if cart is not empty, show button to continue shopping process
                  Padding(
                      padding: const EdgeInsets.all(30),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                // stack navigation
                                context, MaterialPageRoute(builder: (context) {
                              // Navigate to customer info screen to get customer details for purchase
                              return CustomerInfoScreen(
                                  cartItems:
                                      cartItems); // send cart list data to next page
                            }));
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                Colors.blueGrey, // Set the background color
                          ),
                          child: const Text(
                            "Go to Checkout",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                    ) // button label
              // Output cart status
            ]),
      ),
    );
  }
}
