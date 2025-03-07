/*
Group: 09
Team Member: Q_Ha, N_Tran, Z_Zhou
Course: INFO2310
File: Menu for Screens
Project name: Absolute Value App
*/

class Item {
  // Item Attributes
  int id; // Unique identifier for each item
  String name; // Name of item
  int quantity; // Available amount of item
  double price; // price of 1 of this item
  final String imagePath; // ✅ Ensure this field exists

  // Item Constructor
  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imagePath, // ✅ Make sure this is required
  });

  // helper function to convert an instance of the class to a Map object
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "quantity": quantity,
      "price": price,
      "imagePath": imagePath, // ✅ Include imagePath
    };
  }

  // helper function to create an instance of this class from a Map data structure
  Item.fromJson(Map<String, dynamic> jsonString)
      : id = jsonString["id"],
        name = jsonString["name"],
        quantity = jsonString["quantity"],
        price = jsonString["price"],
        imagePath = jsonString["imagePath"] ?? ""; // ✅ Ensure imagePath is initialized
}
