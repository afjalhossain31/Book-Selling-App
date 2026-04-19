import 'package:flutter/foundation.dart';

class CartManager extends ChangeNotifier {
  // Singleton Pattern
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  // List of books in the cart
  final List<Map<String, String>> _cartItems = [];

// eta private variable jekhane sob data thake like nam, dam 
  List<Map<String, String>> get items => _cartItems; 

  void addToCart(Map<String, String> book) {
    _cartItems.add(book); // Cart e book add kore dey
    notifyListeners(); // UI-ke update korar jonno
  }

  void clearCart() {
    _cartItems.clear(); // Cart ke khali kore dey
    notifyListeners();
  }

// 0-9 char o dot char chara baki sob kisu remove kore price ke double e convert korar jonno like, 200tk -- 200.0
  double calculateSubtotal() {
    double subtotal = 0;
    for (var item in _cartItems) {
      double price = double.tryParse(item["price"]!
      .replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0; // 0.0 default hisabe newa hoi jeno kres na hoi
      //print("Price: $price");
      subtotal += price;
    }
    return subtotal;
  }
}
