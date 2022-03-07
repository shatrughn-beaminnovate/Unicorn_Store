import 'dart:convert';

import 'package:unicorn_store/Data/Models/Category/category.dart';
import 'package:http/http.dart' as http;
import 'package:unicorn_store/UI/constant.dart';

class CategoryServiceApi {
  Future<Category> getCategories() async {
    var response = await http.get(Uri.parse("$kDefaultBaseUrl/category"));


      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        var data = Category.fromJson(decode);
        return data;
      } else {
        throw Exception(response.statusCode);
      }
    } 
}
