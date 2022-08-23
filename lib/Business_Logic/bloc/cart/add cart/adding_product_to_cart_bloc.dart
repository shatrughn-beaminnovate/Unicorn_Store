import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Data/Repositories/cart/add_to_cart_repository.dart';

import '../../../../Data/Models/Cart/Add Product To Cart/adding_product_to_cart.dart';
part 'adding_product_to_cart_event.dart';
part 'adding_product_to_cart_state.dart';

class AddingProductToCartBloc
    extends Bloc<AddingProductToCartEvent, AddingProductToCartState> {
  final AddToCartRepository addToCartRepository = AddToCartRepository();
  AddingProductToCartBloc() : super(AddingProductToCartInitial()) {
    on<AddProductToCart>((event, emit) async {
      try {
        emit(AddingProductToCartLoading());
        final addToCart = await addToCartRepository.addProductToCart(
            event.productId, event.token);
        await Future.delayed(const Duration(seconds: 1));
        if (addToCart.status!) {
          emit(AddingProductToCartLoaded(addToCart));
        } else {
          emit(AddingProductToCartFailure(addToCart.message!));
        }
      } catch (e) {
        emit(AddingProductToCartFailure(e.toString()));
      }
    });
  }
}
