


import 'package:json_annotation/json_annotation.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_images.dart';
part 'order_product_data.g.dart';

@JsonSerializable()
class OrderProductData
{

  final int? id;
  final String? name;
  final int? saleprice;
  final List<TypeImages> images;

  OrderProductData(this.id, this.name, this.saleprice, this.images);

 
  factory OrderProductData.fromJson(Map<String, dynamic> orderProductData) =>
      _$OrderProductDataFromJson(orderProductData);
  Map<String, dynamic> toJson() => _$OrderProductDataToJson(this);

  @override
  String toString() {
    return 'OrderProductData(id: $id, name: $name, saleprice: $saleprice, images: $images)';
  }





}