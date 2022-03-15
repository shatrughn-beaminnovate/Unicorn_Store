import 'package:json_annotation/json_annotation.dart';

import 'package:unicorn_store/Data/Models/MyAccount/Order%20History/order_items.dart';

part 'order_data.g.dart';

@JsonSerializable()
class OrderData {
  final int? id;

  @JsonKey(name: "order_number")
  final int? orderNumber;
  final String? status;

  @JsonKey(name: "ordered_on")
  final String? orderedOn;
  final int? total;

  @JsonKey(name: "ordered_product")
  final List<OrderItems>? orderedProduct;

  OrderData(
    this.id,
    this.orderNumber,
    this.status,
    this.orderedOn,
    this.total,
    this.orderedProduct,
  );

  factory OrderData.fromJson(Map<String, dynamic> orderData) =>
      _$OrderDataFromJson(orderData);
  Map<String, dynamic> toJson() => _$OrderDataToJson(this);

  @override
  String toString() {
    return 'OrderData(id: $id, orderNumber: $orderNumber, status: $status, orderedOn: $orderedOn, total: $total, orderedProduct: $orderedProduct)';
  }
}
