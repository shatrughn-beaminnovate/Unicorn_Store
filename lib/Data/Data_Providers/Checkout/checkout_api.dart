import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/Checkout/Order%20Summary/order_summary_data.dart';
import 'package:unicorn_store/Data/Models/Checkout/Transaction/Payment%20Module%20Data/payment_module.dart';
import 'package:unicorn_store/Data/Models/Checkout/Transaction/View%20Payment%20Module/view_payment_module.dart';
import 'package:unicorn_store/Data/Models/Checkout/Transaction/View%20Payment%20Module/view_payment_module_data.dart';
import 'package:unicorn_store/Data/Models/Default%20Address/default_address_data.dart';
import 'package:unicorn_store/Data/Models/Search%20Store/search_store.dart';
import 'dart:convert';
import 'package:unicorn_store/UI/constant.dart';

import '../../Models/Default Address/default__addreses_field_data.dart';

class CheckoutApi {
  Future<Map<String, dynamic>> updateBillingAddress(
      DefaultAddressFieldData data, String token) async {
    String body = json.encode(data.toJson());

    var response =
        await http.put(Uri.parse("$kSecondDefaultBaseUrl/save-billing-address"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "X-Auth-Token": token,
              "Authorization": "Bearer $kDefaultApiKey"
            },
            body: body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      return decode;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<DefaultAddressData> getUserDefaultAddress(String token) async {
    var response = await http.get(
      Uri.parse("$kDefaultBaseUrl/get_customer_default_address"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      var data = DefaultAddressData.fromJson(body);

      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<SearchStore> searchStore(String city, String token) async {
    String body;
    if (city == " ") {
      Map<String, dynamic> data = {};
      body = json.encode(data);
    } else {
      Map<String, dynamic> data = {"city": city};
      body = json.encode(data);
    }

    var response =
        await http.post(Uri.parse("$kDefaultBaseUrl/get_store_by_city"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "X-Auth-Token": token,
            },
            body: body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = SearchStore.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Map<String, dynamic>> updateShippingStoreAddress(
      String storeId, String token) async {
    Map<String, dynamic> data = {
      "store_id": storeId,
      "address_type": "shipping address"
    };
    String body = json.encode(data);

    var response =
        await http.put(Uri.parse("$kSecondDefaultBaseUrl/ship-to-store"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              "X-Auth-Token": token,
              "Authorization": "Bearer $kDefaultApiKey"
            },
            body: body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      return decode;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Map<String, dynamic>> updateShippingAddress(
      DefaultAddressFieldData data, String token) async {
    String body = json.encode(data.toJson());

    var response = await http.put(
        Uri.parse("$kSecondDefaultBaseUrl/save-shipping-address"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "X-Auth-Token": token,
          "Authorization": "Bearer $kDefaultApiKey"
        },
        body: body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      return decode;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<OrderSummaryData> getUserOrderSummary(String token) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/order_summary"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      var data = OrderSummaryData.fromJson(body);

      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  //This is for get total checout product value
  Future<Map<String, dynamic>> getUserCheckoutProductTotal(String token) async {
    var response = await http.get(
      Uri.parse("$kSecondDefaultBaseUrl/checkout/update-order-value"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      return body;
    } else {
      throw Exception(response.statusCode);
    }
  }

  //getting payment gateway details
  Future<ViewPaymentModule> getPaymentModuleDetails(String token) async {
    var response = await http.get(
      Uri.parse(
          "$kSecondDefaultBaseUrl/public/api/v1/transactions/get_payment_moduless"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Auth-Token": token,
        "Authorization": "Bearer $kDefaultApiKey"
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var data = ViewPaymentModule.fromJson(body);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

  //getting particular payment module data
  Future<PaymentModule> getSpecificPaymentModuleData(
      ViewPaymentModuleData data, String token) async {
    String body = json.encode(data.toJson());

    var response = await http.post(
        Uri.parse(
            "$kSecondDefaultBaseUrl/public/api/v1/transactions/process_payment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "X-Auth-Token": token,
          "Authorization": "Bearer $kDefaultApiKey"
        },
        body: body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data=PaymentModule.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }

    //to check order status
  Future<PaymentModule> getPaymentOrderStatus(
      String orderId, String token) async {
    var response = await http.get(
        Uri.parse(
            "$kSecondDefaultBaseUrl/public/api/v1/transactions/check_payment_status?order_id=$orderId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "X-Auth-Token": token,
          "Authorization": "Bearer $kDefaultApiKey"
        }
        );
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data=PaymentModule.fromJson(decode);
      return data;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
