


import 'package:json_annotation/json_annotation.dart';

import 'data.dart';
part 'product_page_details.g.dart';

@JsonSerializable()
class ProductPageDetail
{  

  @JsonKey(name:"data")
  final Product product;

  ProductPageDetail(this.product);

  factory ProductPageDetail.fromJson(Map<String, dynamic> productPageDetails) =>
      _$ProductPageDetailFromJson(productPageDetails);
  Map<String, dynamic> toJson() => _$ProductPageDetailToJson(this);

  
  @override
  String toString() {
    return 'ProductPageDetail(product: $product)';
  }

}