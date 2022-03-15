import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Data_Providers/My%20Account/Order%20History/order_history_product_details_api.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Order%20History/order_history_details.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Order%20History/order_history_product_details_repository.dart';

part 'order_history_product_details_event.dart';
part 'order_history_product_details_state.dart';

class OrderHistoryProductDetailsBloc extends Bloc<
    OrderHistoryProductDetailsEvent, OrderHistoryProductDetailsState> {
  OrderHistoryProductDetailsBloc()
      : super(OrderHistoryProductDetailsInitial()) {
    final OrderHistoryProductDetailsRepository orderHistoryProductDetailsRepository =
        OrderHistoryProductDetailsRepository();

    on<LoadOrderHistoryDetailsApiFetch>((event, emit) async {
      try {
        emit(OrderHistoryProductDetailsLoading());
        final _orderHistoyDetails = await orderHistoryProductDetailsRepository
            .getWishlistProductDetails(event.token);

        emit(OrderHistoryProductDetailsLoaded(_orderHistoyDetails));
      } catch (e) {
        emit(OrderHistoryProductDetailsError(e.toString()));
      }
    });
  }
}
