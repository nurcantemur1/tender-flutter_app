import 'dart:convert';

class Product {
  int id;
  int userId;
  String productName;
  double price;
  double endprice;
  String endtime;
  String starttime;
  bool status;

  Product(
      {this.id,
      this.userId,
      this.price,
      this.productName,
      this.endprice,
      this.endtime,
      this.starttime,
      this.status});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      userId: json['userId'],
      productName: json['productName'],
      price: json['price'],
      endprice: json['endprice'],
      endtime: json['endtime'],
      starttime: json['starttime'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['starttime'] = this.starttime;
    data['endprice'] = this.endprice;
    data['endtime'] = this.endtime;
    data['status'] = this.status;
    return data;
  }

  static List<Product> fromJsonList(String str) =>
      List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
}
