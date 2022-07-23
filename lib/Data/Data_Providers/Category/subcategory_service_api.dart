import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/Accessories%20product%20Wishlist/accessories_wishlist_product_details.dart';
import 'package:unicorn_store/UI/constant.dart';

class SubCategoryServiceApi {
  final _baseUrl = "$kDefaultBaseUrl/sub_category";

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
    Map data = {"category_id": categoryID,"sub_category": true, "product": true};
    var body = jsonEncode(data);
   

    var response = await http.post(Uri.parse(_baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: body);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
    
      var data = AccessoriesListData.fromJson(decode);
    

      return data;
    } else {
      throw Exception(response.statusCode);
    }

  }

  //This will load Accessories Product Details
  Future<AccessoriesWishlistProductDetails> getAccessoriesProductDetails(
      String productId, String token) async {
    String url = "$kDefaultBaseUrl/product/$productId";

    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "X-Auth-Token": token,
        "Connection": "keep-alive"
      },
    );
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = AccessoriesWishlistProductDetails.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
