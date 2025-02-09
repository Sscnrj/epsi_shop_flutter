import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/bo/product.dart';
import '/ui/providers/cart_provider.dart';

class DetailPage extends StatefulWidget {
  final int productId;
  const DetailPage(this.productId, {super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Product? product;
  bool isLoading = true;
  int selectedQuantity = 1; // Quantité par défaut

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final res = await http.get(
        Uri.parse("https://fakestoreapi.com/products/${widget.productId}"));
    if (res.statusCode == 200) {
      setState(() {
        product = Product.fromMap(jsonDecode(res.body));
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(product!.title)),
      body: Column(
        children: [
          Image.network(product!.image),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product!.description),
          ),
          Text(product!.getPrice()),

          // Sélecteur de quantité
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quantité : "),
              DropdownButton<int>(
                value: selectedQuantity,
                items: List.generate(10, (index) => index + 1)
                    .map((q) => DropdownMenuItem(
                          value: q,
                          child: Text(q.toString()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedQuantity = value!;
                  });
                },
              ),
            ],
          ),

          // Bouton d'ajout au panier avec redirection automatique
          ElevatedButton(
            onPressed: () {
              cartProvider.addToCart(product!, selectedQuantity);
              context.go("/cart"); // Redirige directement vers le panier
            },
            child: Text("Ajouter au panier"),
          ),
        ],
      ),
    );
  }
}
