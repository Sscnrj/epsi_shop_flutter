import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/ui/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Panier")),
      body: cartProvider.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Votre panier est vide.",
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.go("/"),
                    child: Text("Retour à l'accueil"),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final product =
                          cartProvider.cartItems.keys.elementAt(index);
                      final quantity = cartProvider.cartItems[product]!;

                      return ListTile(
                        leading: Image.network(product.image, width: 50),
                        title: Text(product.title),
                        subtitle: Text("Prix unitaire : ${product.getPrice()}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cartProvider.removeFromCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "${product.title} retiré du panier !")),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cartProvider.updateQuantity(
                                    product, quantity - 1);
                              },
                            ),
                            Text(quantity.toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cartProvider.updateQuantity(
                                    product, quantity + 1);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Affichage du total et bouton de paiement
                if (cartProvider.cartItems.isNotEmpty)
                  Column(
                    children: [
                      Text(
                          "Total: ${cartProvider.totalPrice.toStringAsFixed(2)}€"),
                      ElevatedButton(
                        onPressed: () {
                          // On ajoutera ici l'envoi de la requête d'achat plus tard
                        },
                        child: Text("Procéder au paiement"),
                      ),
                    ],
                  ),
              ],
            ),
    );
  }
}
