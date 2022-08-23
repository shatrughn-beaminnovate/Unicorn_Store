import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Data/Models/Cart/View%20Cart/cart_product_data.dart';
import 'package:unicorn_store/Data/Repositories/cart/add_to_cart_repository.dart';

part 'view_cart_product_list_event.dart';
part 'view_cart_product_list_state.dart';

class ViewCartProductListBloc
    extends Bloc<ViewCartProductListEvent, ViewCartProductListState> {
  final AddToCartRepository addToCartRepository = AddToCartRepository();

  ViewCartProductListBloc() : super(ViewCartProductListInitial()) {
    on<LoadCartProductList>((event, emit) async {
      try {
        emit(ViewCartProductListLoading());
        final productList =
            await addToCartRepository.viewCartProductList(event.token);
        if (productList.isNotEmpty) {
          emit(ViewCartProductListLoaded(productList));
        }
        else{
           emit( ViewCartProductListEmpty());
        }
      } catch (e) {
        //print(e);
        emit(ViewCartProductListFailure(e.toString()));
      }
    });
  }
}
