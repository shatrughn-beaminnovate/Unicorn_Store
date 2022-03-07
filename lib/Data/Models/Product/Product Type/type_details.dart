
import 'package:json_annotation/json_annotation.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/product_details.dart';
part 'type_details.g.dart';

@JsonSerializable()
class ProductTypeDetails
{
   ProductDetails? data;
  
  ProductTypeDetails(this.data);

      
  factory ProductTypeDetails.fromJson(Map<String, dynamic> productTypeDetails) =>
      _$ProductTypeDetailsFromJson(productTypeDetails);
  Map<String, dynamic> toJson() => _$ProductTypeDetailsToJson(this);





}