import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/Category/Subcategory_Types/subcategory_types_list.dart';
import 'package:unicorn_store/UI/constant.dart';

class SubcategoryTypesServiceApi {
  final _baseUrl = "$kDefaultBaseUrl/subcategory_types/";

  Future<SubcategoryTypesList> getSubcategoriesTypes(
      String subcategoryID) async {
    var response = await http.get(Uri.parse(_baseUrl + subcategoryID));
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = SubcategoryTypesList.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
