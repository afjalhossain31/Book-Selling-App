import 'package:flutter/foundation.dart';

class CartManager extends ChangeNotifier {
  // Singleton Pattern
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  // List of books in the cart
  final List<Map<String, String>> _cartItems = [];

  List<Map<String, String>> get items => _cartItems;

  void addToCart(Map<String, String> book) {
    _cartItems.add(book);
    notifyListeners(); // UI-ke update korar jonno
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double calculateSubtotal() {
    double subtotal = 0;
    for (var item in _cartItems) {
      double price = double.tryParse(item["price"]!.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      subtotal += price;
    }
    return subtotal;
  }
}
