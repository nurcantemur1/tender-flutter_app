import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/photoservice.dart';

// ignore: must_be_immutable
class ProductListCard extends StatefulWidget {
  final Product product;
  const ProductListCard({Key key, this.product}) : super(key: key);

  @override
  _ProductListCardState createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  IconData iconss;
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
                    Image(
                      image: NetworkImage(images),
                      fit: BoxFit.fill,
                      height: 120,
                      width: 100,
                    ),
                    Text(widget.product.productName),
                    widget.product.status
                        ? Icon(Icons.check)
                        : Icon(Icons.close),
                    widget.product.status
                        ? Text("Onaylandı")
                        : Text("Onay bekliyor"),
                    Padding(
                      padding: EdgeInsets.only(left: 75),
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
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
