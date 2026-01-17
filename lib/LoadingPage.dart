import 'package:flutter/material.dart';
import 'package:product_app/ProductScreen.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

 @override
  State<LoadingPage> createState() => _LoadingPageState();

  
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Productscreen()),
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
