import 'dart:convert';

import 'package:flutter_application_1/models/dto/registerDto.dart';
import 'package:flutter_application_1/models/loginModel.dart';
import 'package:flutter_application_1/models/tokenModel.dart';
import 'package:flutter_application_1/services/baseApi.dart';
import 'package:flutter_application_1/services/shared_pref.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static String controller = "auth/";

  static Future<bool> login(LoginModel model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    var data = json.decode(jsonn.body)["data"];
    var tokenModel = TokenModel.fromJson(data);

    if (tokenModel != null) {
      await SharedPref.add("token", tokenModel.token);
      await SharedPref.add("email", model.email);
      return true;
    }
    return false;
  }

  static Future<bool> register(RegisterDto model) async {
    var jsonn = await http.post(
      BaseApi.getUrl(controller, "register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(model.toJson()),
    );
    print(jsonn.toString());
    var data = json.decode(jsonn.body)["data"];
    print(data.toString());
    var tokenModel = TokenModel.fromJson(data);

    if (tokenModel != null) {
      await SharedPref.add("token", tokenModel.token);
      await SharedPref.add("email", model.email);
      return true;
    }
    return false;
  }
}
