// lib/pages/landing_page.dart

import 'package:flutter/material.dart';
import 'package:app_ecommerc/pages/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selamat Datang!')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigasi ke HomePage
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: const Text('Lihat Semua Produk'),
        ),
      ),
    );
  }
}
