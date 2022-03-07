import 'package:json_annotation/json_annotation.dart';

import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/wishlist_product.dart';
part 'wishlist_details.g.dart';

@JsonSerializable()
class WishlistDetails {
  final List<WishlistProduct>? data;

  WishlistDetails(this.data);

  factory WishlistDetails.fromJson(Map<String, dynamic> wishlistDetails) =>
      _$WishlistDetailsFromJson(wishlistDetails);
  Map<String, dynamic> toJson() => _$WishlistDetailsToJson(this);

  @override
  String toString() => 'WishlistDetails(data: $data)';
}
