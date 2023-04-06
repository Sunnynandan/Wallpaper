import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API with ChangeNotifier {
  static const _API_KEY = "21190498-0fc3b9f7e4015e20da843c981";

  Future<List<String>> fetchData(
      {pageno,
      String subject = "",
      editor_choice,
      image_type,
      order,
      orientation = ""}) async {
    List<String> imgList = [];
    print(pageno);
    try {
      final response = await http.get(Uri.parse(
          "https://pixabay.com/api/?key=$_API_KEY&q=${Uri.encodeComponent(subject)}&editors_choice=${editor_choice}&orientation=${orientation}&image_type=${image_type}&page=$pageno&order=$order"));

      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      List<dynamic> list = data['hits'];

      for (var element in list) {
        imgList.add(element['webformatURL']);
      }
    } catch (e) {}
    return imgList;
  }
}
