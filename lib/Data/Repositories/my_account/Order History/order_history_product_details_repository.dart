import 'package:unicorn_store/Data/Data_Providers/My%20Account/Order%20History/order_history_product_details_api.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Order%20History/order_history_details.dart';

class OrderHistoryProductDetailsRepository {
  final _orderHistoryProductDetailsApi = OrderHistoryProductDetailsApi();

  //Load List of user order
  Future<OrderHistoryDetails> getOrderHistoryProductDetails(String token) {
    return _orderHistoryProductDetailsApi.getOrderHistoryProductDetails(token);
  }
}
