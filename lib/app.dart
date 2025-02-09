import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'ui/pages/cart_page.dart';
import 'ui/pages/detail_page.dart';
import 'ui/pages/list_product.dart';
import 'ui/providers/cart_provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final router = GoRouter(routes: [
    GoRoute(path: "/", builder: (_, __) => ListProductPage(), routes: [
      GoRoute(
          name: "detail",
          path: "detail/:idProduct",
          builder: (_, state) {
            int idProduct = int.parse(state.pathParameters["idProduct"] ?? "0");
            return DetailPage(idProduct);
          }),
      GoRoute(path: "cart", builder: (_, __) => CartPage()),
    ]),
  ]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'EPSI Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
      ),
    );
  }
}
