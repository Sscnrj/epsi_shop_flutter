import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bo/product.dart';

class ListProductPage extends StatelessWidget {
  ListProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: ListView.builder(
          itemCount: listProducts.length,
          itemBuilder: (ctx, index) => InkWell(
            onTap: () => ctx.go('/detail/${listProducts[index].id}'),
            child: ListTile(
              leading: Image.network(
                listProducts[index].image,
                width: 90,
                height: 90,
              ),
              title: Text(listProducts[index].name),
              subtitle: Text(listProducts[index].description),
            ),
          ),
        ));
  }
}
