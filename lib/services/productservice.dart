import 'dart:convert';

import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/services/baseApi.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static String controller = "products/";

  static Future<List<Product>> getall() async {
    var jsonn = await http.get(BaseApi.getUrl(controller, "getallaccept"));
    var data = json.encode(json.decode(jsonn.body)["data"]);
    print(data);
    if (data == null) return null;
    return Product.fromJsonList(data);
  }

  static Future<List<Product>> getallbyuser(int userId) async {
    var jsonn = await http.get(
        BaseApi.getUrl(controller, "getallbyuser?userId=" + userId.toString()));
    var data = json.encode(json.decode(jsonn.body)["data"]);
    print(data);
    if (data == null) return null;
    return Product.fromJsonList(data);
  }

  static Future<Product> get(int id) async {
    var jsonn = await http
        .get(BaseApi.getUrl(controller, "getbyid?id=" + id.toString()));
    var data = json.decode(jsonn.body)["data"];
    if (data == null) return null;
    return Product.fromJson(data);
  }

  static Future<Product> update(Product model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    print("objefgvct");
    print(jsonn.body);
    var data = json.decode(jsonn.body)["data"];
    print(jsonn.body);
    return Product.fromJson(data);
  }

  static Future<Product> add(Product model) async {
    print(model);
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    print(jsonn.body);
    var data = json.decode(jsonn.body)["data"];
    print(jsonn.body);
    return Product.fromJson(data);
  }
  /* static Future<DataResponseModel> add(Product model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );

    // return Product.fromJson(data);
    if (jsonn != null) {
      print(jsonn.body);
      DataResponseModel dm = new DataResponseModel();
      var data = json.decode(jsonn.body)["data"];
      dm.data = data != null ? Product.fromJson(data) : null;
      dm.success = String.fromJson(json.decode(jsonn.body)["success"]);
      
      dm.message = json.decode(jsonn.body)["message"];
      return dm;
    }
    return null;
  }*/
}
