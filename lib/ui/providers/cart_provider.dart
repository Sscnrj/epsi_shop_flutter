import 'package:flutter/material.dart';

import '/bo/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cartItems =
      {}; // Map pour stocker produit + quantité

  Map<Product, int> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] =
          (_cartItems[product]! + quantity).clamp(1, 99); // Min 1, Max 99
    } else {
      _cartItems[product] = quantity;
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      _cartItems.remove(product);
    } else {
      _cartItems[product] = quantity;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice => _cartItems.entries.fold(0,
      (sum, entry) => sum + (entry.key.price * entry.value * 1.2)); // TVA 20%
}
