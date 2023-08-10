import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/photoservice.dart';

class WinnerItemCard extends StatefulWidget {
  final Product product;
  const WinnerItemCard({Key key, this.product}) : super(key: key);

  @override
  _WinnerItemCardState createState() => _WinnerItemCardState();
}

class _WinnerItemCardState extends State<WinnerItemCard> {
  String images =
      "https://res.cloudinary.com/tenderapp/image/upload/v1628888610/r0j8h0n0w04a063sesyq.png";
  @override
  void initState() {
    super.initState();
    getimage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.product == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
              child: Card(
                color: Colors.white,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Image(
                          image: NetworkImage(images),
                          fit: BoxFit.fill,
                          height: 120,
                          width: 100,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(widget.product.productName.toUpperCase(),
                            style: TextStyle(color: Colors.black87)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(widget.product.endprice.toString(),
                            style: TextStyle(color: Colors.black87)),
                        Padding(
                            padding: EdgeInsets.only(left: 60),
                            child: Text("sipariş alındı.",
                                style: TextStyle(color: Colors.black87))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  getimage() async {
    await PhotoService.getall(widget.product.id).then((value) {
      if (value != null) {
        setState(() {
          images = value.first.url;
        });
      }
    });
  }
}
