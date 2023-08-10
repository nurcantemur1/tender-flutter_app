import 'dart:convert';

class BaseApi {
  static String apiUrl = "http://192.168.162.218:8084/api/";

  static Uri getUrl(String controller, String method) {
    return Uri.parse(apiUrl + controller + method);
  }

  static getData(String body) {
    return json.encode(json.decode(body)["data"]);
  }

  static isSuccess(String body) {
    return json.decode(body)["success"];
  }

  static getMessage(String body) {
    return json.encode(json.encode(json.decode(body)["message"]));
  }
}
