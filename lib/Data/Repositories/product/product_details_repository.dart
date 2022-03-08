import 'package:unicorn_store/Data/Data_Providers/Product/product_details_api.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_details.dart';

class ProductDetailsRepository {
  final _productDetailsServiceApi = ProductDetailsServiceApi();

  Future<ProductTypeDetails> getProductDetails(String productDetailsId) {
    return _productDetailsServiceApi.getProductDetails(productDetailsId);
  }

  Future<dynamic> getProductPageDetails(Map<String,String> productValue,String productTypeId,String customerId){
    return _productDetailsServiceApi.getProductPageDetails(productValue,productTypeId,customerId);
  }

}
