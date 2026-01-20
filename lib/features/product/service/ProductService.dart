import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:product_app/features/product/model/ProductModel.dart';

class ProductService {
  final String _baseUrl = 'https://dummyjson.com/products';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final List products = data['products'];

      return products
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow; 
    }
  }
}
