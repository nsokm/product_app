import 'package:flutter/material.dart';

class Productdetailscreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const Productdetailscreen({super.key, required this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductdetailscreenState();
  }
}

//margin: const EdgeInsets.all(16),
class _ProductdetailscreenState extends State<Productdetailscreen> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 195, 173, 255),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 195, 173, 255), Colors.white],
            ),
            // color: Colors.white,
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(32),
            //   topRight: Radius.circular(32),
            // ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Card(
                elevation: 8,
                shadowColor: Colors.purple.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color.fromARGB(255, 195, 173, 255), width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Image.network(
                            product['thumbnail'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product['price']}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product['description'],
                        style: TextStyle(fontSize: 16),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
