import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/services/baseApi.dart';

class UserService {
  static String controller = "users/";

  static Future<User> getbyMail(email) async {
    var jsonn =
        await http.get(BaseApi.getUrl(controller, "getbymail?email=" + email));
    return User.fromJson(json.decode(jsonn.body));
  }

  static Future<User> update(User model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "update"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    var data = json.decode(jsonn.body)["data"];
    return User.fromJson(data);
  }
}
