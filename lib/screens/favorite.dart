import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/favoriteservice.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';
import 'package:flutter_application_1/widget/product-card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Product> products;

  @override
  void initState() {
    print("products");
    super.initState();
    SharedPref.getString("email").then((mail) {
      if (mail != null) {
        UserService.getbyMail(mail).then((value) async {
          FavoriteService.getallbyuser(value.id).then((value1) {
            setState(() {
              products = value1;
            });
          });
        });
      } else {
        setState(() {
          showToast("Giriş yapmalısınız");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takip Edilenler'),
      ),
      drawer: MyApp.menu,
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

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
