import 'dart:convert';

class Image {
  int id;
  int productId;
  String url;

  Image({this.id, this.productId, this.url});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      productId: json['productId'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['url'] = this.url;
    return data;
  }

  static List<Image> fromJsonList(String str) =>
      List<Image>.from(json.decode(str).map((x) => Image.fromJson(x)));
}
