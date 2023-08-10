import 'dart:convert';
import 'package:flutter_application_1/models/offer.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/baseApi.dart';
import 'package:http/http.dart' as http;

class OfferService {
  static String controller = "offers/";

  static Future<Offer> getlastoffer(int productId) async {
    print(productId);
    var jsonn = await http.get(BaseApi.getUrl(
        controller, "getlastoffer?productId=" + productId.toString()));
    var data = json.decode(jsonn.body)["data"];
    if (data == null) return null;
    return Offer.fromJson(data);
  }

  static Future<bool> add(Offer model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    return jsonn != null;
  }

  static Future<List<Product>> getallearned(int userId) async {
    var jsonn = await http.get(
        BaseApi.getUrl(controller, "getallearned?userId=" + userId.toString()));
    var data = json.encode(json.decode(jsonn.body)["data"]);
    print(data);
    if (data == null) return null;
    return Product.fromJsonList(data);
  }
}
