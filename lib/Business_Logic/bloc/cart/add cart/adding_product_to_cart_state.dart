part of 'adding_product_to_cart_bloc.dart';

abstract class AddingProductToCartState extends Equatable {
  const AddingProductToCartState();

  @override
  List<Object> get props => [];
}

class AddingProductToCartInitial extends AddingProductToCartState {}

class AddingProductToCartLoading extends AddingProductToCartState {}

class AddingProductToCartLoaded extends AddingProductToCartState {
  final AddingProductToCart addingProductToCart;

  const AddingProductToCartLoaded(this.addingProductToCart);
}

class AddingProductToCartFailure extends AddingProductToCartState {
  final String message;

  const AddingProductToCartFailure(this.message);
}
