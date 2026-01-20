import 'package:flutter/material.dart';
import 'package:product_app/features/product/page/ProductScreen.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

 @override
  State<Loading> createState() => _LoadingState();

  
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProductScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.deepPurpleAccent,
                ),
              ),
    ));
  }
}
