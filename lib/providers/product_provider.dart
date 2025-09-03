import 'package:flutter/material.dart';
import 'package:app_ecommerc/models/product.dart';
import 'package:app_ecommerc/repositories/product_repository.dart';

enum ProductListState { initial, loading, loaded, error }

class ProductProvider with ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<Product> _products = [];
  ProductListState _state = ProductListState.initial;
  String _errorMessage = '';

  List<Product> get products => _products;
  ProductListState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _state = ProductListState.loading;
    notifyListeners(); // beri tahu UI bahwa data sedang dimuat

    try {
      _products = await _productRepository.fetchAllProducts();
      _state = ProductListState.loaded;
    } catch (e) {
      _state = ProductListState.error;
      _errorMessage = e.toString();
    }

    notifyListeners(); // beri tahu ui bahwa state telah diperbaharui
  }
}
