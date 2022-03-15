import 'package:json_annotation/json_annotation.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Order%20History/order_data.dart';
part 'order_history_details.g.dart';

@JsonSerializable()
class OrderHistoryDetails {
  final List<OrderData>? data;

  OrderHistoryDetails(this.data);

  factory OrderHistoryDetails.fromJson(Map<String, dynamic> orderHistoryDetails) =>
      _$OrderHistoryDetailsFromJson(orderHistoryDetails);
  Map<String, dynamic> toJson() => _$OrderHistoryDetailsToJson(this);

  @override
  String toString() {
    return 'OrderHistoryProductDetails(data: $data,)';
  }
}
