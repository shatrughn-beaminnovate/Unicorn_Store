import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/Cart/Add%20Product%20To%20Cart/adding_product_to_cart.dart';
import 'package:unicorn_store/Data/Models/Cart/total_product_count.dart';
import 'package:unicorn_store/Data/Models/Service%20Check%20Pincode/pincode_service_check_data.dart';
import 'dart:convert';
import 'package:unicorn_store/UI/constant.dart';

import '../../Models/Cart/View Cart/cart_product_data.dart';

class AddToCartApi {
  Future<AddingProductToCart> addProductToCart(int productId, String token) async {
    Map<String, dynamic> data = {"product_id": productId, "quantity": 1};
    String body = json.encode(data);

    var response =
        await http.post(Uri.parse("$kSecondDefaultBaseUrl/cart/add_product"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "X-Auth-Token": token,
              "Authorization": "Bearer $kDefaultApiKey"
            },
            body: body);
    //  print("body: $body  responseCode:${response.request} header:${response.headers}");
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = AddingProductToCart.fromJson(decode);

      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<CartProductData>> viewCartProductList(String token) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/view_cart"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    //  print("body:${response.body} responseCode:${response.request} header:${response.headers}");
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<CartProductData> data = List<CartProductData>.from(
          l.map((model) => CartProductData.fromJson(model)));

      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<TotalProductCount> totalCartProductCount(String token) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/total_cart_items"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    //  print("body:${response.body} responseCode:${response.request} header:${response.headers}");
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      TotalProductCount data = TotalProductCount.fromJson(body);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Map<String, dynamic>> updateCartItem(int cartItemId, String quantity, String token) async {
    Map<String, dynamic> data = {
      "cart_item_id": cartItemId,
      "quantity": quantity
    };
    String body = json.encode(data);

    var response =
        await http.post(Uri.parse("$kSecondDefaultBaseUrl/cart/update_cart"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "X-Auth-Token": token,
              "Authorization": "Bearer $kDefaultApiKey"
            },
            body: body);
    // print(
    //     "body: $body  responseCode:${response.request} header:${response.headers}");
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      return decode;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Map<String, dynamic>> removeCartItem(int cartItemId, String token) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/remove-item/$cartItemId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    // print("responseCode:${response.request} header:${response.headers}");
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      return decode;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Map<String, dynamic>> moveToWishlistCartItem(int cartItemId, String token) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/move-to-wishlist/$cartItemId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    // print("responseCode:${response.request} header:${response.headers}");
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);

      return decode;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<PinCodeServiceCheck> productServiceCheck(String pincode) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/check_pincode/$pincode"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = PinCodeServiceCheck.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
