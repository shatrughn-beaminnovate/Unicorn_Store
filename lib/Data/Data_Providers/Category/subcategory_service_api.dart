import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';
import 'package:unicorn_store/UI/constant.dart';

class SubCategoryServiceApi {
  final _baseUrl = "$kDefaultBaseUrl/sub_category/";

  Future<SubCategoryList> getSubCategories(String categoryID) async {
    Map data = {"sub_category": true, "product": false};
    var body = jsonEncode(data);

    var response = await http.post(Uri.parse(_baseUrl + categoryID),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      var data = SubCategoryList.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  //This will accessories data
  Future<AccessoriesListData> getAccessoriesCategoryData(
      String categoryID) async {
    Map data = {"sub_category": true, "product": true};
    var body = jsonEncode(data);

    var response = await http.post(Uri.parse(_baseUrl + categoryID),
        headers: {"Content-Type": "application/json"}, body: body);
    
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      var data = AccessoriesListData.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
    

  }
}
