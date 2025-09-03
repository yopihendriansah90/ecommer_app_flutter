import 'package:flutter/material.dart';
import 'package:app_ecommerc/models/product.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  void addFavorite(Product product) {
    if (!_favoriteItems.contains(product)) {
      _favoriteItems.add(product);
      notifyListeners(); // memberi tahu UI bahwa data berubah
    }
  }

  void removeFavorite(Product product) {
    _favoriteItems.remove(product);
    notifyListeners(); // memberi tahu UI bahwa data berubah
  }

  bool isFavorite(Product product) {
    return _favoriteItems.contains(product);
  }
}
