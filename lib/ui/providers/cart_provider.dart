import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/bo/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cartItems = {}; // Map Produit -> Quantité

  Map<Product, int> get cartItems => _cartItems;

  void addToCart(Product product, int quantity) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = (_cartItems[product]! + quantity).clamp(1, 99);
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

  // Fonction pour envoyer la requête d'achat
  Future<void> sendPurchaseRequest(BuildContext context) async {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Votre panier est vide !")),
      );
      return;
    }

    final url = Uri.parse("http://ptsv3.com/t/EPSISHOPC1/");
    final List<Map<String, dynamic>> items = _cartItems.entries.map((entry) {
      return {
        "id": entry.key.id,
        "title": entry.key.title,
        "price": entry.key.price,
        "quantity": entry.value,
        "total": (entry.key.price * entry.value * 1.2).toStringAsFixed(2)
      };
    }).toList();

    final Map<String, dynamic> payload = {
      "items": items,
      "total_price": totalPrice.toStringAsFixed(2),
    };

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Commande envoyée avec succès !")),
      );
      clearCart(); // On vide le panier après l'achat
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'envoi de la commande.")),
      );
    }
  }
}
