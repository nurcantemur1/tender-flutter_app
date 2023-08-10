import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/offerservice.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';
import 'package:flutter_application_1/widget/winner-item-card.dart';

class Winners extends StatefulWidget {
  const Winners({Key key}) : super(key: key);

  @override
  _WinnersState createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  List<Product> products;
  var userid;
  @override
  void initState() {
    super.initState();
    getEarnedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Kazandıklarım'),
      ),
      body: products == null
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return WinnerItemCard(
                  product: products[index],
                );
              },
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

  getEarnedProducts() async {
    await getuser();
    OfferService.getallearned(userid).then((value) {
      setState(() {
        products = value;
      });
    });
  }
}
