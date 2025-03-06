/*
GROUP: 01
FILE: Item Class (Can be either in the catalog or placed in the cart)
PAGE AUTHOR: Nini Tran
COURSE: PROG2435
SECTION: 2
ASSIGNMENT: Final Project
APPLICATION NAME: Absolute Value (eCommerce App that sells math products)
*/

class Item {
  // Item Attributes
  int id; // Unique identifier for each item
  String name; // Name of item
  int quantity; // Available amount of item
  double price; // price of 1 of this item
  
  // Item Constructor
  Item({required this.id, required this.name, required this.quantity, required this.price});

  // helper function to convert an instance of the class to a Map object
  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "quantity": quantity, "price": price};
  }
  
  // helper function to create an instance of this class from a Map data structure
  Item.fromJson(Map<String, dynamic> jsonString)
      : id = jsonString["id"],
        name = jsonString["name"],
        quantity = jsonString["quantity"],
        price = jsonString["price"];
}

