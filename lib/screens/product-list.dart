import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/screens/product-add.dart';
import 'package:flutter_application_1/services/productservice.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';
import 'package:flutter_application_1/widget/product-list-card.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> userproducts;
  var userid;
  @override
  void initState() {
    super.initState();
    getbyUserProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Ürünlerim'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 170, top: 10),
            child: CupertinoButton(
              child: Text("Ürün Ekle"),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ProductAdd()));
              },
            ),
          ),
          userproducts == null
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: userproducts.length,
                    itemBuilder: (context, index) {
                      return ProductListCard(
                        product: userproducts[index],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  getuser() async {
    var value = await SharedPref.getString("email");
    if (value != null) {
      var user = await UserService.getbyMail(value);
      if (user != null) {
        setState(() {
          userid = user.id;
        });
      }
    }
  }

  getbyUserProducts() async {
    await getuser();
    ProductService.getallbyuser(userid).then((value) {
      setState(() {
        print(value);
        userproducts = value;
      });
    });
  }
}
/*  CupertinoButton(
            child: Text("Ürün Ekle"),
            color: Colors.blue,
            padding: const EdgeInsets.only(left: 180, top: 10),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ProductAdd()));
            },
          ), */
