import 'dart:convert';
import 'package:unicorn_store/Data/Models/Category/category.dart';
import 'package:http/http.dart' as http;
import 'package:unicorn_store/UI/constant.dart';

class CategoryServiceApi {
  Future<List<Category>> getCategories() async {
    var response = await http.get(Uri.parse("$kDefaultBaseUrl/category"));


      if (response.statusCode == 200) {
        Iterable l = json.decode(response.body);
        List<Category> category =
            List<Category>.from(l.map((model) => Category.fromJson(model)));

        return category;
      } else {
        throw Exception(response.statusCode);
      }

  }
}
