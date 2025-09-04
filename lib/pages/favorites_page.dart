import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_ecommerc/pages/product_detail_page.dart';
import 'package:app_ecommerc/providers/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit')),
      body: Consumer<FavoritesProvider>(
        builder: (context, FavoritesProvider, child) {
          if (FavoritesProvider.favoriteItems.isEmpty) {
            return const Center(
              child: Text('Anad belum memiliki produk favorite.'),
            );
          }
          return ListView.builder(
            itemCount: FavoritesProvider.favoriteItems.length,
            itemBuilder: (context, index) {
              final product = FavoritesProvider.favoriteItems[index];
              return ListTile(
                leading: Image.network(
                  product.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text('Rp ${product.price.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
                trailing: IconButton(
                  onPressed: () {
                    FavoritesProvider.removeFavorite(product);
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
