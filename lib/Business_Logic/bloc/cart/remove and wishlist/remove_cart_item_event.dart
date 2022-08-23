part of 'remove_cart_item_bloc.dart';

abstract class RemoveCartItemEvent extends Equatable {
  const RemoveCartItemEvent();

  @override
  List<Object> get props => [];
}

class RemoveItemCart extends RemoveCartItemEvent {
  final int cartItemId;
  final String token;
  const RemoveItemCart(this.cartItemId, this.token);
  @override
  List<Object> get props => [cartItemId, token];
}


class MoveToWishlistCartItem extends RemoveCartItemEvent {
  final int cartItemId;
  final String token;
  const MoveToWishlistCartItem(this.cartItemId, this.token);
  @override
  List<Object> get props => [cartItemId, token];
}
