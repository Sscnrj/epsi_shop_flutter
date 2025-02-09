import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/bo/product.dart';
import '/ui/providers/cart_provider.dart';

class ListProductPage extends StatelessWidget {
  ListProductPage({super.key});

  Future<List<Product>> getProducts() async {
    final res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      List<dynamic> listMapProducts = jsonDecode(res.body);
      return listMapProducts.map((lm) => Product.fromMap(lm)).toList();
    }
    throw Exception("Erreur de téléchargement");
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('EPSI Shop'),
        actions: [
          IconButton(
            onPressed: () => context.go("/cart"),
            icon: Badge(
              label: Text(cartProvider.cartItems.length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur de chargement des produits"));
          } else {
            final listProducts = snapshot.data!;
            return ListView.builder(
              itemCount: listProducts.length,
              itemBuilder: (ctx, index) => InkWell(
                onTap: () => ctx.go('/detail/${listProducts[index].id}'),
                child: ListTile(
                  leading: Image.network(listProducts[index].image,
                      width: 90, height: 90),
                  title: Text(listProducts[index].title),
                  subtitle: Text(listProducts[index].getPrice()),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
