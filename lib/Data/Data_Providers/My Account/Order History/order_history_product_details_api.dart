import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/MyAccount/Order%20History/order_history_details.dart';
import 'package:unicorn_store/UI/constant.dart';

class OrderHistoryProductDetailsApi {
//This will load all the history of user orders
  Future<OrderHistoryDetails> getOrderHistoryProductDetails(
      String token) async {
  
      var response = await http.get(
        Uri.parse("$kDefaultBaseUrl/customer_orders"),
        headers: {
          "Content-Type": "application/json",
          "X-Auth-Token": token,
          "Connection": "keep-alive"
        },
      );

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);
        var data = OrderHistoryDetails.fromJson(decode);
        return data;
      } else {
        throw Exception(response.statusCode);
      }
    } 
}
