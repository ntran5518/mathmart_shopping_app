/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// --- Program imports ---
// Packages
import 'package:flutter/material.dart';

// Screens
import 'screens/welcome_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/shopping_cart_screen.dart';

// Main method
void main() {
  runApp(const MyApp()); // runs the app
}

// Application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MATHMART SHOPPING APPLICATION", // Sets the browser tab title
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MenuScreen(), // Launches the menu screen
    );
  }
}

// MENU SCREEN (Stateless)
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key}); // Constructor

  // Overrides the build method
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal, // AppBar background color
          title: const Text("MATHMART SHOPPING APP",style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: const TabBar(labelColor: Colors.blue,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Selected tab text style
              tabs: [
            Tab(icon: Icon(Icons.home, size: 40), text: "Home"),
            Tab(icon: Icon(Icons.list, size: 40), text: "Catalog"),
            Tab(icon: Icon(Icons.shopping_cart, size: 40), text: "Shopping Cart"),
          ]),
        ),
        body: Container(
          color: Colors.yellow[50], // Body background color
          child: TabBarView(children: [
            const WelcomeScreen(),
            const CatalogScreen(),
            ShoppingCartScreen(
              cartItems: cartItems,
            ),
          ]),
        ),
      ),
    );
  }
}
