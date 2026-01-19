import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/ProductDetailScreen.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductScreen();
  }
}

class _ProductScreen extends State<Productscreen> {
  List<dynamic> _product = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }

      final data = json.decode(response.body);
      final List products = data["products"];

      products.sort(
        (a, b) => a['title'].toString().compareTo(b['title'].toString()),
      );

      setState(() {
        _product = products;
      });
    } catch (e) {
      _errorMessage = 'Something went wrong';
      _showErrorDialog(_errorMessage!);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error ❌'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Scrollbar(
                radius: const Radius.circular(10),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _product.length,
                  itemBuilder: (context, index) {
                    final product = _product[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.network(
                            product["thumbnail"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          product['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '\$${product['price']}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  Productdetailscreen(product: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
