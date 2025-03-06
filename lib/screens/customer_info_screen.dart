/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: MathMart Shopping App
*/

// ignore_for_file: unnecessary_this, must_be_immutable

// Program imports
import 'package:flutter/material.dart';
import 'catalog_screen.dart';
import 'success_screen.dart';
// Classes
import '../classes/item.dart'; // Import Item class to create instances of a product of Absolute Value

// CUSTOMER INFORMATION SCREEN (Stateful)
class CustomerInfoScreen extends StatefulWidget {
  List<Item> cartItems; // list of items user has placed in shopping cart

  CustomerInfoScreen({super.key, required this.cartItems}); // constructor

  @override
  CustomerInfoScreenState createState() {
    return CustomerInfoScreenState();
  }
}

// Customer Info Screen State
class CustomerInfoScreenState extends State<CustomerInfoScreen> {
  String totalErrors = ""; // variable to hold complete error message

  // Text field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isMember = false; // switch boolean
  bool getEmailedReceipt = false; // check boolean
  // Valid email regular expression format
  final emailRegex =
      RegExp('[a-zA-Z0-9.]+@(gmail|email|yahoo|outlook).[A-Za-z]{2,3}');

  /// Dispose of controllers when the widget is no longer needed
  @override
  void dispose() {
    nameController.dispose(); // dispose of text field controllers
    emailController.dispose();
    super.dispose(); // call parent method
  }

  /// Click handler to submit customer info for a purchase
  void submitInformation() {
    // take text from text fields to store user input
    String name = nameController.text; // inputted name
    String email = emailController.text; // inputted email

    setState(() {
      String nameErrors = ""; // Error messages specific to each field
      String emailErrors = "";
      totalErrors = ""; // reset errors

      // Check inputs and update the Text() widget
      if (name.isEmpty) {
        // Empty name field
        nameErrors = "Customer name cannot be blank.";
        totalErrors += "$nameErrors\n";
      }
      if (email.isEmpty) {
        // Empty email field
        emailErrors = "Customer email cannot be blank.";
        totalErrors += emailErrors;
      } else if (!emailRegex.hasMatch(email)) {
        // Invalid email entered
        emailErrors =
            "Customer email must be in valid email format (someone@email.com).";
        totalErrors += emailErrors;
      }

      // check if there are errors of not
      if (totalErrors == "") {
        // No errors -- Customer info validated

        // Switch Screens (to Success/Receipt page)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SuccessScreen(
              // send valid user input as class attributes to success screen
              customerName: name,
              customerEmail: email,
              isMember: isMember,
              getEmailedReceipt: getEmailedReceipt,
              items: cartItems, // list of shopping cart items
            );
          }),
        );
      } else {
        // if errors exist, user will need empty textfields to reinput info
        // clear textboxes and prepare for new input
        nameController.text = "";
        emailController.text = "";
        isMember = false;
        getEmailedReceipt = false;
      }
    });
  }

  /// Override the build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // app title -- customer information input form
          title: const Text(
            "Customer Information Form",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal, // Use a custom background color
        ),
        body: Padding(
            padding: const EdgeInsets.all(
                16), // add padding for layout beautification
            child: Column(
                // column to arrange elements vertically
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Instructions for the page
                  const Padding(
                    padding: EdgeInsets.all(
                        10), // add padding for layout beautification
                    child: Text(
                      "Please enter your contact details to complete your purchase!",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        10), // add padding for layout beautification
                    child: TextField(
                        controller: nameController, // set controller
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(), // border around textfield
                          labelText: "Enter your name", // textfield label
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        10), // add padding for layout beautification
                    child: TextField(
                        controller: emailController, // set controller
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(), // border around textfield
                          labelText: "Enter your email", // textfield label
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    // add padding for layout beautification

                    child: SwitchListTile(
                        // user ticks whether or not they are a store member
                        title: const Text("Store member?"),
                        value: isMember,
                        activeColor:
                            Colors.green, // Change the toggle color when active
                        onChanged: (bool updatedSwitchValue) {
                          setState(() {
                            isMember =
                                updatedSwitchValue; // set boolean accordingly
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        10), // add padding for layout beautification
                    child: CheckboxListTile(
                      // user checks if they want their receipt emailed to them
                      title: const Text("Get emailed receipt?"),
                      value: this.getEmailedReceipt,
                      activeColor: Colors.green,
                      onChanged: (bool? updatedCheckValue) {
                        setState(() {
                          if (updatedCheckValue != null) {
                            getEmailedReceipt =
                                updatedCheckValue; // set boolean accordingly
                          }
                        });
                      },
                    ),
                  ),

                  FilledButton(
                    // button to submit user info & finish purchase
                    onPressed: submitInformation,
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          Colors.blueGrey, // Set the background color
                    ), // call submit method
                    child: const Text("Submit"), // button to submit information
                  ),

                  // Red error message text widget for any errors (if input is invalid)
                  Text(
                    totalErrors,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ])));
  }
}
