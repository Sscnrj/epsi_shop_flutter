import 'package:flutter/material.dart';

import '../../bo/product.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.product, {super.key});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Produit'),
      ),
      body: Column(
        children: [
          Image.network(product.image),
          LineTitlePrice(product: product),
          Description(product: product),
          Spacer(),
          Button(),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(product.description,
          style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Acheter cet article')),
      ),
    );
  }
}

class LineTitlePrice extends StatelessWidget {
  const LineTitlePrice({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(product.name, style: Theme.of(context).textTheme.headlineMedium),
          Text(product.getPrice(),
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
