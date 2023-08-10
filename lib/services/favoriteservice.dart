import 'dart:convert';

import 'package:flutter_application_1/models/favorite.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/baseApi.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  static String controller = "favorites/";

  static Future<List<Product>> getallbyuser(int userId) async {
    var jsonn = await http.get(
        BaseApi.getUrl(controller, "getallbyuser?userId=" + userId.toString()));
    var data = json.encode(json.decode(jsonn.body)["data"]);
    print(data);
    //  if (data == null) return null;
    return Product.fromJsonList(data);
  }

  static Future<int> favoritecount(int productId) async {
    var jsonn = await http.get(
        BaseApi.getUrl(controller, "favoritecount?id=" + productId.toString()));
    // var data = json.encode(json.decode(jsonn.body)["data"]);
    // print(data);
    //  if (data == null) return null;
    return int.parse(jsonn.body);
  }

  static Future<bool> add(Favorite model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    return jsonn != null;
  }

  static Future<Favorite> delete(Favorite model) async {
    var jsonn = await http.delete(
      BaseApi.getUrl(controller, "delete"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    var data = json.decode(jsonn.body)["data"];
    return Favorite.fromJson(data);
  }
}
