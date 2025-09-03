import 'package:flutter/material.dart';
import 'package:app_ecommerc/models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  void addProduct(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners(); // beri tau ui bahwa keranjang berugah
  }

  // fungsi untuk manambah kuantitas

  void incrementQuantity(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
      notifyListeners(); // beri tau ui bahwa keranjang berugah
    }
  }

  // fungsi untuk mengurangi kuanititas
  void decrementQuantity(Product product) {
    int currentQuantity = _cartItems[product]!;
    if (currentQuantity > 1) {
      _cartItems[product] = currentQuantity - 1;
    } else {
      // jika kuantas 1, hapus produk dari keranjang
      _cartItems.remove(product);
    }
    notifyListeners(); // beri tau ui bahwa keranjang berugah
  }

  void removeProduct(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems.remove(product);
    }
    notifyListeners(); // beri tau ui bahwa keranjang berugah
  }

  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }
}
