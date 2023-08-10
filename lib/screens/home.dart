import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/productservice.dart';
import 'package:flutter_application_1/widget/product-card.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Product> products;
  @override
  void initState() {
    super.initState();
    ProductService.getall().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      body: products == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  productId: products[index].id,
                );
              },
            ),
    );
  }
}
