import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/product%20add%20or%20delete%20response/product_add_delete_response.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/wishlist_details.dart';
import 'package:unicorn_store/UI/constant.dart';

class WishlistDetailsProductApi {
  
  //This will load Wishlist product list of the user
  Future<WishlistDetails> getWishlistProductDetails(
      String customerID, String token) async {
    var response = await http.get(
      Uri.parse("$kDefaultBaseUrl/wishlist?customer_id=$customerID"),
      headers: {
        "Content-Type": "application/json",
        "X-Auth-Token": token,
        "Connection": "keep-alive"
      },
    );
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = WishlistDetails.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
 
 //Wishlist product add or delete
   Future<ProductAddDeleteResponse> addOrDeleteWishlistProduct(
      String customerID,String productId,String token) async {
    var response = await http.get(
      Uri.parse("$kDefaultBaseUrl/add_to_wishlist?product_id=$productId&customer_id=$customerID"),
      headers: {
        "Content-Type": "application/json",
        "X-Auth-Token": token,
        "Connection": "keep-alive"
      },
    );
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = ProductAddDeleteResponse.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }


}
