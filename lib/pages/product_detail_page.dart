import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_ecommerc/models/product.dart';
import 'package:provider/provider.dart';
import 'package:app_ecommerc/providers/cart_provider.dart';
import 'package:app_ecommerc/pages/cart_page.dart';
import 'package:flutter_html/flutter_html.dart'; // <-- 1. Impor package

class ProductDetailPage extends StatelessWidget {
  final String deskrispsiProduk =
      "<p>Ini adalah <b>deskripsi produk</b> dalam format <i>HTML</i>.</p><ul><li>Fitur 1</li><li>Fitur 2</li></ul>😄";

  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  if (cartProvider.cartItems.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cartProvider.cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  height: 300,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Nama Produk
            Padding(
              padding: EdgeInsetsGeometry.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Harga Produk
                  Text(
                    'Rp ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Deskripsi produk:',
                    style: TextStyle(fontSize: 16),
                  ),
                  // const SizedBox(height: 8),
                  // Deskripsi Produk dalam format HTML
                  Html(data: deskrispsiProduk),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // panggil addProduct dari CartProduct
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addProduct(product);

                      // tampilkan pesan konfirmasi (snackbar)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${product.name} telah ditambahkan ke keranjang}',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text('tambah ke keranjang'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
