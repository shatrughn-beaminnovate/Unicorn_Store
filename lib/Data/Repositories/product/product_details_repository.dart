import 'package:unicorn_store/Data/Data_Providers/Product/product_details_api.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/product_details.dart';

class ProductDetailsRepository {
  final _productDetailsServiceApi = ProductDetailsServiceApi();

  Future<ProductDetails> getProductDetails(String productDetailsId) {
    return _productDetailsServiceApi.getProductDetails(productDetailsId);
  }

  Future<dynamic> getProductPageDetails(Map<String,String> productValue,String productTypeId,String token){
    return _productDetailsServiceApi.getProductPageDetails(productValue,productTypeId,token);
  }

}
