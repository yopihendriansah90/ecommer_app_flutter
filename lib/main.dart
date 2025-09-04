import 'package:app_ecommerc/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_ecommerc/providers/cart_provider.dart';
import 'package:app_ecommerc/providers/product_provider.dart';
import 'package:app_ecommerc/providers/favorites_provider.dart';
import 'package:app_ecommerc/providers/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // menggunakan multiprovider untuk mengeloal beberapa provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Walatra App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LandingPage(),
      ),
    );
  }
}
