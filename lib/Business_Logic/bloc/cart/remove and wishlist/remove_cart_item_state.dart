part of 'remove_cart_item_bloc.dart';

abstract class RemoveCartItemState extends Equatable {
  const RemoveCartItemState();

  @override
  List<Object> get props => [];
}

class RemoveCartItemInitial extends RemoveCartItemState {}

class RemoveCartItemLoading extends RemoveCartItemState {}

class RemoveCartItemSuccess extends RemoveCartItemState {
  final Map<String, dynamic> removeResponse;
  final int productIndex;
  const RemoveCartItemSuccess(this.removeResponse, this.productIndex);
}

class MoveToWishlistProductSuccess extends RemoveCartItemState {
  final Map<String, dynamic> removeResponse;

  const MoveToWishlistProductSuccess(this.removeResponse);
}

class RemoveCartItemFailure extends RemoveCartItemState {
  final String message;
  const RemoveCartItemFailure(this.message);
}
