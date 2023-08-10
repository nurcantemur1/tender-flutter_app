import 'dart:convert';

class Favorite {
  int id;
  int productId;
  int userId;

  Favorite({id, productId, userId}) {
    this.id = id;
    this.productId = productId;
    this.userId = userId;
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json['id'], productId: json['productId'], userId: json['userId']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['userId'] = this.userId;

    return data;
  }

  static List<Favorite> fromJsonList(String str) =>
      List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));
}
