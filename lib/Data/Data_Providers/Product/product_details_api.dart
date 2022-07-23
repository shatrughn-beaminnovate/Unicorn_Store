import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unicorn_store/Data/Models/Product/Product%20Page/product_page_details.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/product_details.dart';
import 'package:unicorn_store/UI/constant.dart';

class ProductDetailsServiceApi {
  final _baseUrl = "$kDefaultBaseUrl/types/";

  Future<ProductDetails> getProductDetails(String productDetailsId) async {


    var response = await http.get(Uri.parse(_baseUrl + productDetailsId));

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      var data = ProductDetails.fromJson(decode);

      return data;
    } else {
      throw Exception(response.statusCode);
    }}
  
  

  Future<dynamic> getProductPageDetails(Map<String, String> productValue,
      String productTypeId,String token) async {
    String url = "$kDefaultBaseUrl/dictionary_product";
   
    //Empty product object
    // Product product=Product();

    Map data = {
      'type_id': productTypeId,
      'options': productValue
    };
    String body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
              "X-Auth-Token": token,
          },
          body: body);

      if (response.statusCode == 200) {
        var decode = jsonDecode(response.body);

        Map res = {"data": []};

        if (res.toString() == decode.toString()) {
          return "failed";
        } else {
          var data = ProductPageDetail.fromJson(decode);
          return data;
        }
      } else {
        throw Exception(response.statusCode);
      }
  
  }
}
