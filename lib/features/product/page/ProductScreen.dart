import 'package:flutter/material.dart';
import 'package:product_app/features/product/model/ProductModel.dart';
import 'package:product_app/features/product/page/ProductDetailScreen.dart';
import 'package:product_app/features/product/service/ProductService.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductService _service = ProductService();

  List<ProductModel> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _isLoading = true);

    try {
      final result = await _service.fetchProducts();

      result.sort((a, b) => a.title.compareTo(b.title));

      setState(() {
        _products = result;
      });
    } catch (e) {
      _showErrorDialog();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error ❌'),
        content: const Text('Something went wrong'),
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
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          radius: const Radius.circular(10),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final product = _products[index];

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
                      product.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '\$${product.price}',
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
                            ProductDetailScreen(product: product),
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
