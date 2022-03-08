import 'package:json_annotation/json_annotation.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/product%20add%20or%20delete%20response/product_add_delete_data.dart';
part 'product_add_delete_response.g.dart';

@JsonSerializable()
class ProductAddDeleteResponse {
  final ProductAddDeleteData? data;

  ProductAddDeleteResponse(this.data);

  factory ProductAddDeleteResponse.fromJson(
          Map<String, dynamic> productAddDeleteData) =>
      _$ProductAddDeleteResponseFromJson(productAddDeleteData);
  Map<String, dynamic> toJson() => _$ProductAddDeleteResponseToJson(this);

  @override
  String toString() {
    return 'ProductAddDeleteResponse(productAddDeleteData: $data,)';
  }
}
