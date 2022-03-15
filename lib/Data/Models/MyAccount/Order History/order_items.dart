import 'package:json_annotation/json_annotation.dart';

import 'package:unicorn_store/Data/Models/MyAccount/Order%20History/order_product_data.dart';
part 'order_items.g.dart';

@JsonSerializable()
class OrderItems {
  final int? id;

  @JsonKey(name: "order_id")
  final int? orderId;

  @JsonKey(name: "product_id")
  final int? productId;
  final int? quantity;
  final OrderProductData? contents;

  OrderItems(
      this.id, this.orderId, this.productId, this.quantity, this.contents);

  factory OrderItems.fromJson(Map<String, dynamic> orderItems) =>
      _$OrderItemsFromJson(orderItems);
  Map<String, dynamic> toJson() => _$OrderItemsToJson(this);
    
  @override
  String toString() {
    return 'OrderItems(id: $id, orderId: $orderId, productId: $productId, quantity: $quantity, contents: $contents)';
  }
}
