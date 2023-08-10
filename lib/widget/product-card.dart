import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/favorite.dart';
import 'package:flutter_application_1/models/offer.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/models/zaman.dart';
import 'package:flutter_application_1/screens/product-detail.dart';
import 'package:flutter_application_1/services/favoriteservice.dart';
import 'package:flutter_application_1/services/offerservice.dart';
import 'package:flutter_application_1/services/photoservice.dart';
import 'package:flutter_application_1/services/productservice.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:flutter_application_1/services/userservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  final int productId;

  const ProductCard({Key key, this.productId}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isEnable = false;
  Product product;
  Zaman sayac = Zaman(gun: 0, saat: 0, dk: 0, sn: 0);
  Zaman zaman = Zaman(gun: 0, saat: 0, dk: 0, sn: 0);
  bool load = false;
  Color iconColor = Colors.blue;
  // String pey;
  String images =
      "https://res.cloudinary.com/tenderapp/image/upload/v1628888610/r0j8h0n0w04a063sesyq.png";
  int count = 50;
  var sayi;
  var userid;
  String time = "";
  @override
  void initState() {
    super.initState();
    init();

    // getpey();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          child: !load
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(image: NetworkImage(images)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.productName.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .apply(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ilk fiyat: " + product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_downward,
                                ),
                                onPressed: () {
                                  if (count > 1) {
                                    setState(() {
                                      count--;
                                    });
                                  }
                                },
                              ),
                              Text(count.toString()),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_upward,
                                ),
                                onPressed: () {
                                  if (count < 100) {
                                    setState(() {
                                      count++;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          Card(
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              child: Text("Teklif Ver"),
                              onPressed: () {
                                if (isEnable) {
                                  peyver();
                                }
                              },
                            ),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(35, 35)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CountdownFormatted(
                        duration: Duration(
                            days: zaman.gun,
                            hours: zaman.saat,
                            minutes: zaman.dk,
                            seconds: zaman.sn),
                        builder: (BuildContext ctx, String remaining) {
                          return Text(
                            remaining,
                            style: TextStyle(fontSize: 30),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: Text(time.toString()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 130),
                          child: Text("Verilen son teklif : " +
                                  product.endprice.toString() ??
                              "Teklif verilmedi."),
                          // child: Text("pey" + getpey(widget.product.id)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: iconColor,
                          ),
                          onPressed: () async {
                            // Favorite model= [id=1,userId =]
                            // FavoriteService.add(model);
                            var mail = await SharedPref.getString("email");
                            mail == null
                                ? showToast("Giriş yapmalısınız")
                                : begen();
                          },
                        ),
                        Text(sayi.toString() + " kişi takip ediyor."),
                      ],
                    )
                  ],
                ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => ProductDetail(id: product.id)));
      },
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

  init() async {
    await getuser();
    await getproduct();
    await getfavorite();
    await favoritecount();
    await getimage();
    setState(() {
      //  sayac = diff(product.starttime);
      load = true;
    });
    myfunc();
    // show();
  }

  //        sonraki-önceki
  // dif(starttime)  start-now
  // dif(starttime,endtime)
  // dif(endtime)

  /* diff(String starttime, {String endtime}) {
    DateFormat f = new DateFormat("dd.MM.yyyy HH:mm");
    DateTime mdate1 = f.parse(starttime);
    Duration d;
    if (endtime == null) {
      DateTime now = DateTime.now();
      d = mdate1.difference(now);

      print(now.toString());
      print(mdate1.toString());
    } else {
      DateTime mdate2 = f.parse(endtime);
      d = mdate2.difference(mdate1);
      print(mdate1.toString());
      print(mdate2.toString());
    }

    Zaman zaman = Zaman(gun: 0, saat: 0, dk: 0, sn: 0);

    if (d.isNegative) {
      time = "Bitti";
    } else {
      zaman.sn = d.inSeconds % 60;
      zaman.dk = d.inMinutes % 60;
      zaman.saat = d.inHours % 24;
      zaman.gun = d.inDays;
      print(zaman.gun.toString() +
          "-" +
          zaman.saat.toString() +
          "-" +
          zaman.dk.toString() +
          "-" +
          zaman.sn.toString());
    }
    return zaman;
  }

   show() {
    // yayından önce
    // yayın sırasında
    // sonra
    Timer.periodic(Duration(seconds: 1), (timer) {
    
    });
    DateFormat f = new DateFormat("dd.MM.yyyy HH:mm");
    DateTime mdate = f.parse(product.starttime);
    DateTime now = DateTime.now();
    if (mdate.compareTo(now) == 0) {
      setState(() {
        print("object");
        sayac = diff(product.starttime, endtime: product.endtime);
        isEnable = true;
      });
    }
    mdate = f.parse(product.endtime);
    if (mdate.compareTo(now) < 0) {
      setState(() {
        time = "Bitti";
        isEnable = false;
      });
    }
  }*/

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

  peyver() async {
    Offer model = Offer(
      id: 0,
      pey: count,
      peytime: DateTime.now().toString(),
      productId: product.id,
      userId: userid,
    );
    print(count);
    var isadded = await OfferService.add(model);
    if (isadded) {
      product.endprice = product.endprice + double.parse(count.toString());
      var sonuc = await ProductService.update(product);
      if (sonuc != null) {
        getproduct();
      }
    }
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

  getproduct() async {
    var model2 = await ProductService.get(widget.productId);
    if (mounted) {
      setState(() {
        product = model2;
      });
    }
  }

  favoritecount() async {
    await FavoriteService.favoritecount(widget.productId).then((value) {
      setState(() {
        sayi = value.toString();
      });
    });
  }

  getimage() async {
    await PhotoService.getall(widget.productId).then((value) {
      if (value != null) {
        setState(() {
          images = value.first.url;
        });
      }
    });
  }

  myfunc() {
    Duration d;
    DateFormat f = new DateFormat("dd.MM.yyyy HH:mm");
    DateTime startdate = f.parse(product.starttime);
    DateTime enddate = f.parse(product.endtime);
    print(startdate);
    print(enddate);
    if (startdate.compareTo(DateTime.now()) < 0 &&
        enddate.compareTo(DateTime.now()) > 0) {
      //canlı
      d = enddate.difference(startdate);
      if (d.isNegative) {
        setState(() {
          time = " cBitti";
          isEnable = false;
        });
      } else {
        setState(() {
          time = " Yayının bitmesine kalan süre:";
          isEnable = true;
          zaman.sn = d.inSeconds % 60;
          zaman.dk = d.inMinutes % 60;
          zaman.saat = d.inHours % 24;
          zaman.gun = d.inDays;
          print(zaman.gun.toString() +
              "-" +
              zaman.saat.toString() +
              "-" +
              zaman.dk.toString() +
              "-" +
              zaman.sn.toString());
        });
      }
    } else if (startdate.compareTo(DateTime.now()) > 0) {
      d = startdate.difference(DateTime.now());
      if (d.isNegative) {
        setState(() {
          time = "aBitti";
          isEnable = false;
        });
      } else {
        setState(() {
          isEnable = false;
          time = "Yayının başlamasına kalan süre:";
          zaman.sn = d.inSeconds % 60;
          zaman.dk = d.inMinutes % 60;
          zaman.saat = d.inHours % 24;
          zaman.gun = d.inDays;
          print(zaman.gun.toString() +
              "-" +
              zaman.saat.toString() +
              "-" +
              zaman.dk.toString() +
              "-" +
              zaman.sn.toString());
        });
      }
    } else {
      setState(() {
        time = "Yayın Bitti";
        isEnable = false;
        zaman.sn = 0;
        zaman.dk = 0;
        zaman.saat = 0;
        zaman.gun = 0;
        print(zaman.gun.toString() +
            "-" +
            zaman.saat.toString() +
            "-" +
            zaman.dk.toString() +
            "-" +
            zaman.sn.toString());
      });
    }
  }
}
