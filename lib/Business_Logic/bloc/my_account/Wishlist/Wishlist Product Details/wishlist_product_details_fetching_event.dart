part of 'wishlist_product_details_fetching_bloc.dart';

abstract class WishlistProductDetailsFetchingEvent extends Equatable {
  const WishlistProductDetailsFetchingEvent();

  @override
  List<Object> get props => [];
}

class LoadWishlistProductDetailsApiFetch
    extends WishlistProductDetailsFetchingEvent {
  final String customerId;
  final String token;

  const LoadWishlistProductDetailsApiFetch(
      {required this.customerId, required this.token});

  @override
  List<Object> get props => [customerId, token];
}

class AddOrDeleteProductFromWishlistEvent
    extends WishlistProductDetailsFetchingEvent {
  final String customerId;
  final String productId;
  final String token;

  const AddOrDeleteProductFromWishlistEvent(
      {required this.customerId, required this.productId, required this.token});

  @override
  List<Object> get props => [customerId, productId, token];
}
