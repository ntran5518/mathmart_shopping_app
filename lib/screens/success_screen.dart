/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// Program Imports
// Packages & Dependencies
import 'package:flutter/material.dart';
import 'package:mathmart_shopping_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Data persistence
import 'dart:convert';
// Screens
import 'catalog_screen.dart';
// Classes
import '../classes/item.dart'; // Item class import to make Item objects


String returnYesNo(bool result) {
  // takes a bool, returns a string
  if (result) {
    return "Yes";
  } else {
    return "No";
  }
}

// SUCCESS SCREEN (Stateless) -- prints the customer receipt & information
class SuccessScreen extends StatelessWidget {
  // Properties
  final String customerName; // name of customer -- cannot be blank
  final String
      customerEmail; // email of customer -- cannot be blank & must be valid
  final bool isMember; // status of whether customer is member or not
  final bool getEmailedReceipt; // member's choice to receive a receipt or not
  final List<Item> items; // list of items customer has purchased

  // Methods using Shared Preferences -- DATA PERSISTENCE
  Future<void> saveData() async {
    // Save to sharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Convert the lists of objects to a string
    String stockItemsAsString = jsonEncode(currentStatusItems);

    // Save the lists of strings to Shared Preferences
    prefs.setString(
        "KEY_STOCK_ITEMS_LIST", stockItemsAsString); // to save the purchase
  }

  // to load persistent data in project for stock quantity to be accurate
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Variables to hold items from storage
    String? stockItemsAsString;
    // Retrieve the list of items
    try {
      // get stock and cart items from shared preferences
      stockItemsAsString = prefs.getString("KEY_STOCK_ITEMS_LIST");

      // assuming the stock items can be found
      if (stockItemsAsString != null) {
        originalItemStock.clear(); // clear current item status
        originalItemStockQuantities.clear(); // clear current quantity status

        // - convert the string to a List
        List jsonMapStockItemList = jsonDecode(stockItemsAsString) as List;

        // - iterate through the list
        for (int i = 0; i < jsonMapStockItemList.length; i++) {
          // - for each item in the list, convert the item to Item object
          Item item = Item.fromJson(jsonMapStockItemList[i]);

          originalItemStock.add(item); // add each item from storage
          originalItemStockQuantities.add(item.quantity); // add each quantity
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e); // print exception
    }
  }

  // to delete all persistent data in shared perferences
  Future<void> deleteData() async {
    // delete everything in Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    // remove all values
    await prefs.clear();
  }

  /// Constructor
  const SuccessScreen(
      {super.key,
      required this.customerName,
      required this.customerEmail,
      required this.isMember,
      required this.getEmailedReceipt,
      required this.items});

  /// Overriding the build method
  @override
  Widget build(BuildContext context) {
    // loop through all cart items and add price
    double total = 0;
    for (Item item in cartItems) {
      total += item.price * item.quantity; // increment the total
    }

    // Checks if customer is store member to get 5% discount
    double totalAfterDiscount = total;
    if (isMember) {
      totalAfterDiscount -= totalAfterDiscount * 0.05; // Member discount is 5%
    }
    saveData(); // save to persist data
    return Scaffold(
      appBar: AppBar(
        // app title
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, // Use a custom background color
      ),
      body: Column(children: [
        const Center(
          // center screen element
          child: Text(
            'Success!', // Header
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        // Receipt has background color, margin, and border
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // padding for layout beautification
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // set horizontal alignment
                mainAxisAlignment:
                    MainAxisAlignment.start, // set vertical alignment
                children: [
                  const Center(
                    // center screen element
                    child: Text(
                      'Receipt', // header
                      style: TextStyle(
                        // style the text
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // print Customer information
                  Text(
                    'Customer Name: $customerName', // name
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black), // style the text
                  ),
                  Text(
                    'Customer Email: $customerEmail', // email
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    'Store Member: ${returnYesNo(isMember)}', // member status
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    'Emailed Receipt: ${returnYesNo(getEmailedReceipt)}', // email receipt choice
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const Divider(
                      height: 30,
                      thickness: 3,
                      color: Colors.black), // line for separation
                  // list the items and each one's attributes
                  ...items.map((item) => Text(
                        'Item: ${item.name}, Qty: ${item.quantity}, Price: \$${item.price.toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),

                      )),
                  const Divider(
                      height: 30,
                      thickness: 3,
                      color: Colors.black), // line for separation

                  // Text to show whether customer is member or not (and discount, if customer is a member)
                  (isMember)
                      ? Text(
                          "Member Discount: \$${(total * 0.05).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )
                      : const Text("No discount",
                          style: TextStyle(fontSize: 18, color: Colors.white)),

                  Text(
                    'Total Cost: \$${totalAfterDiscount.toStringAsFixed(2)}', // formatted price
                    style: const TextStyle(
                      // style the text
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    // center the element on screen
                    child: ElevatedButton(
                      onPressed: () {
                        // button click event
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          // stack navigation
                          // clear cart and values
                          loadData();
                          cartItems.clear();
                          total = 0;
                          return const MenuScreen(); // back to main menu
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        // button styling
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15), // padding for layout beautification
                      ),
                      // Button label
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
