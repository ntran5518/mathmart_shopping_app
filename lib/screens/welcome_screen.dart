/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// Program Imports
import 'package:flutter/material.dart';

// WELCOME SCREEN (Home page)
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return WelcomeScreenState(); // Return the state
  }
}

// WELCOME SCREEN (Stateful)
class WelcomeScreenState extends State<WelcomeScreen> {
  // Fun emoji activity for the user on the Welcome Screen
  String emoji = "🙂"; // Initial emoji

  /// Changes the welcome emoji state on click
  void changeEmoji() {
    setState(() {
      switch (emoji) {
        case "🙂":
          emoji = "😊";
          break;
        case "😊":
          emoji = "😄";
          break;
        case "😄":
          emoji = "😀";
          break;
        default:
          emoji = "🙂";
      }
    });
  }

  /// Overrides the build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WELCOME!",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, // Use a custom background color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Emoji button for user interaction
            ElevatedButton(
              onPressed: changeEmoji,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: const CircleBorder(),
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 100),
              ),
            ),
            const SizedBox(height: 20),
            // Website tagline
            const Text(
              "MathMart Shopping App!",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Website description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "A Shopping App for Math Tools \nlike Calculators, Rulers, and Books.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
