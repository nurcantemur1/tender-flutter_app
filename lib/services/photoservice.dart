import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/image.dart';
import 'package:flutter_application_1/services/baseApi.dart';

class PhotoService {
  static String controller = "photo/";

  static Future<List<Image>> getall(int id) async {
    var jsonn = await http
        .get(BaseApi.getUrl(controller, "getphoto?productId=" + id.toString()));
    var data = json.encode(json.decode(jsonn.body)["data"]);
    print(data);
    if (data == null) return null;
    return Image.fromJsonList(data);
  }

  static Future<bool> add(int productId, PlatformFile file) async {
    var dio = Dio();
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: file.name),
    });
    var response = await dio.post(
        "http://192.168.1.102:8084/api/photo/addphototo?productId=" +
            productId.toString(),
        data: formData);
    if (response != null) {
      print(response.data.toString());
      return true;
    }

    return false;
  }
}
