import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/favorite.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/favoriteservice.dart';
import 'package:flutter_application_1/services/photoservice.dart';
import 'package:flutter_application_1/services/productservice.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  int id;

  ProductDetail({this.id});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  var userid;
  var sayi;
  bool load = false;
  String images =
      "https://res.cloudinary.com/tenderapp/image/upload/v1628888610/r0j8h0n0w04a063sesyq.png";
  Color iconColor = Colors.blue;
  @override
  void initState() {
    super.initState();

    ProductService.get(widget.id).then((value) => this.setState(() {
          product = value;
          if (value != null) {
            setState(() {
              load = true;
            });
            init();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyApp.menu,
      appBar: AppBar(
        title: Text('Ürün Detay'),
      ),
      body: !load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Card(
                child: product == null
                    ? CircularProgressIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(image: NetworkImage(images)),
                          SizedBox(height: 25),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Ürün adı: " + product.productName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .apply(color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Ürünün ilk fiyatı: " + product.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .apply(color: Colors.black87),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Ürünün son fiyatı: " +
                                  product.endprice.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .apply(color: Colors.black87),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: iconColor,
                                  ),
                                  onPressed: () async {
                                    // Favorite model= [id=1,userId =]
                                    // FavoriteService.add(model);
                                    var mail =
                                        await SharedPref.getString("email");
                                    mail == null
                                        ? showToast("Giriş yapmalısınız")
                                        : begen();
                                  },
                                ),
                                Text(sayi.toString() + " kişi takip ediyor."),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
    );
  }

  getimage() async {
    await PhotoService.getall(widget.id).then((value) {
      if (value != null) {
        setState(() {
          images = value.first.url;
        });
      }
    });
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

  getfavorite() async {
    print(userid.toString() + "525");
    if (userid != null && product != null) {
      await FavoriteService.getallbyuser(27).then((value1) {
        if (value1.any((e) => e.id == product.id)) {
          setState(() {
            iconColor = Colors.red;
          });
        } else {
          setState(() {
            iconColor = Colors.amber;
          });
        }
      });
    } else {
      setState(() {
        iconColor = Colors.amber;
      });
    }
  }

  favoritecount() async {
    await FavoriteService.favoritecount(widget.id).then((value) {
      setState(() {
        sayi = value.toString();
      });
    });
  }

  begen() async {
    var mail = await SharedPref.getString("email");
    UserService.getbyMail(mail).then((value) async {
      Favorite model = Favorite(id: 0, productId: product.id, userId: value.id);
      FavoriteService.add(model).then((value) {
        setState(() {
          iconColor = Colors.red;
        });
      });
    });
  }

  getuser() async {
    var value = await SharedPref.getString("email");
    print(value);
    if (value != null) {
      var user = await UserService.getbyMail(value);
      if (user != null) {
        setState(() {
          userid = user.id;
          print(userid);
        });
      }
    }
  }

  init() async {
    await getuser();
    await getfavorite();
    await favoritecount();
    await getimage();
  }
}
