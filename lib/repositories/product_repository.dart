import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_ecommerc/models/product.dart';

class ProductRepository {
  final String _baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> productJsonList = jsonDecode(response.body);
      // mengaubah setiap item JSON menajdi object Product
      return productJsonList
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      // melampirkan exception jika respon gagal
      throw Exception(
        'failed to load products: status code ${response.statusCode}',
      );
    }
  }
}
