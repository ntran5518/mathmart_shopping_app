/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// Program Imports
import 'package:flutter/material.dart';
// Screens
import 'shopping_cart_screen.dart';
import 'product_details_screen.dart';
// Classes
import '../classes/item.dart'; // Import Item class to create instances of a product of Absolute Value

// Using the Item class, create a list of items for the ListView
// List of original items (item info & initial stock)
List<Item> originalItemStock = [
  Item(id: 1, name: "Protractor", quantity: 5, price: 1.99),
  Item(id: 2, name: "Calculator", quantity: 4, price: 15.00),
  Item(id: 3, name: "Ruler", quantity: 7, price: 2.99),
  Item(id: 4, name: "Textbook", quantity: 2, price: 39.99),
  Item(id: 5, name: "Formula Book", quantity: 5, price: 12.99),
];
List<int> originalItemStockQuantities = [5, 4, 7, 2, 5];

// List of current items (with updated quantities)
List<Item> currentStatusItems = [
  Item(id: 1, name: "Protractor", quantity: 5, price: 1.99),
  Item(id: 2, name: "Calculator", quantity: 4, price: 15.00),
  Item(id: 3, name: "Ruler", quantity: 7, price: 2.99),
  Item(id: 4, name: "Textbook", quantity: 2, price: 39.99),
  Item(id: 5, name: "Formula Book", quantity: 5, price: 12.99),
]; // set to original stock originally

List<int> currentItemStockQuantities = [
  5,
  4,
  7,
  2,
  5
]; // set to original stock quantity originally

List<Item> cartItems = []; // list to hold cart items

// CATALOG SCREEN (Stateful)
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key}); // constructor

  @override
  CatalogScreenState createState() {
    return CatalogScreenState(); // creates the state
  }
}

// Catalog Screen State
class CatalogScreenState extends State<CatalogScreen> {
  // store TOTAL item quantity & price
  int totalItemQty = 0;
  double totalCost = 0.0;

  // reset all the items and clear the cart
  void reset() {
    setState(() {
      // clear the existing list of items
      currentStatusItems.clear();
      // update book list with default list of items
      currentStatusItems.addAll([
        // original stock
        Item(id: 1, name: "Protractor", quantity: 5, price: 1.99),
        Item(id: 2, name: "Calculator", quantity: 4, price: 15.00),
        Item(id: 3, name: "Ruler", quantity: 7, price: 2.99),
        Item(id: 4, name: "Textbook", quantity: 2, price: 39.99),
        Item(id: 5, name: "Formula Book", quantity: 5, price: 12.99),
      ]);

      // Reset current stock quantities as well
      currentItemStockQuantities.clear();
      currentItemStockQuantities.addAll([5, 4, 7, 2, 5]);
      // update cart values
      totalCost = 0;
      cartItems.clear(); // Empty the shopping cart
    });
  }

  /// On-click method when customer buys an item
  void buyPressed(Item selectedItem) {
    // set the state
    setState(() {
      if (selectedItem.quantity > 0) {
        // decrease quantity of selected book
        selectedItem.quantity -= 1;
        // increase total number of purchased items
        totalItemQty += 1;
        // update total cost of items in cart
        totalCost += selectedItem.price;
      }
      // store index of selected item
      int selectedIndex = selectedItem.id - 1; // index is 1 less than id

      // update the stock
      currentStatusItems[selectedIndex].quantity = selectedItem.quantity;
      // update the stock quantity
      currentItemStockQuantities[selectedIndex] = selectedItem.quantity;

      // update the cart
      if (cartItems.contains(selectedItem)) {
        // if this item already is in the cart
        cartItems.remove(selectedItem); // remove it
      }
      cartItems.add(selectedItem); // Add the item with the correct quantity
    });
  }

  // override the build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // app title
          title: const Text(
            "Product List",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal, // Use a custom background color
        ),
        body: Container(
            padding:
                const EdgeInsets.all(16), // padding for layout beautification
            child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // centre column elements in centre of screen
                children: [
                  OutlinedButton(
                      onPressed: reset,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Text color
                        side: const BorderSide(
                            color: Colors.black,
                            width: 1), // Border color and thickness
                      ),
                      child: const Row(
                        // row widget for nice formatting of elements on button
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // both icon and text on button for user to reach shopping cart
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text("Reset Items"),
                          ),
                        ],
                      )),
                  // reset button to empty cart & refill stock
                  Expanded(
                      child: ListView.builder(
                          itemCount: currentStatusItems
                              .length, // list length derived from stock items length
                          itemBuilder: (context, index) {
                            // Assign each index with its respective quantity
                            currentStatusItems[index].quantity =
                                currentItemStockQuantities[index];

                            // get the item associated with the current row
                            Item currItem = currentStatusItems[index];
                            // using the item, populate the row ui
                            return ListTile(
                              title: Text(
                                  "${currItem.name} - \$${currItem.price}"),
                              leading: Text("ID: ${currItem.id.toString()}"),
                              subtitle: Text("Quantity: ${currItem.quantity}"),
                              // If there are no items in stock, then show a SOLD OUT text; otherwise, show a BUY button
                              trailing: (currItem.quantity == 0)
                                  ? const Text(
                                      "SOLD OUT",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  : FilledButton(
                                      onPressed: () {
                                        buyPressed(
                                            currItem); // place selected item in the cart on button press
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: Colors
                                            .blueGrey, // Set the background color
                                      ),
                                      child: const Text("Add to cart")),
                              onTap: () {
                                // When user taps the list item, navigate to its respective details page
                                Navigator.push(
                                    // stack navigation
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                  // send specific product details to page
                                  return ProductDetails(
                                    productName: currItem.name,
                                    stockQuantity: currItem.quantity,
                                    productPrice: currItem.price,
                                  );
                                }));
                              },
                            );
                          })),
                  OutlinedButton(
                      onPressed: () {
                        // button to continue shopping process
                        Navigator.push(
                            // navigate to shopping cart screen
                            context, MaterialPageRoute(builder: (context) {
                          return ShoppingCartScreen(
                              cartItems:
                                  cartItems); // send cart items list to cart page
                        }));
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Text color
                        side: const BorderSide(
                            color: Colors.black,
                            width: 1), // Border color and thickness
                      ),
                      child: const Row(
                        // row widget for nice formatting of elements on button
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // both icon and text on button for user to reach shopping cart
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text("Go to Cart"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              Icons.shopping_cart_checkout,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )),
                ])));
  }
}
