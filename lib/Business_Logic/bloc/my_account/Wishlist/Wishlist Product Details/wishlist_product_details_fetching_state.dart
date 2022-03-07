part of 'wishlist_product_details_fetching_bloc.dart';

abstract class WishlistProductDetailsFetchingState extends Equatable {
  const WishlistProductDetailsFetchingState();

  @override
  List<Object> get props => [];
}

class WishlistProductDetailsFetchingInitial
    extends WishlistProductDetailsFetchingState {}

class WishlistProductDetailsFetchingLoading
    extends WishlistProductDetailsFetchingState {}

class WishlistProductDetailsFetchingLoaded
    extends WishlistProductDetailsFetchingState {
  final WishlistDetails? wishlistDetails;

  const WishlistProductDetailsFetchingLoaded(this.wishlistDetails);
}

//State for add or delete product from wishlist
class AddOrRemoveProductFromWishlistSuccess
    extends WishlistProductDetailsFetchingState {
  final ProductAddDeleteResponse? productAddDeleteResponse;

  const AddOrRemoveProductFromWishlistSuccess(this.productAddDeleteResponse);
}

class WishlistProductDetailsFetchingError
    extends WishlistProductDetailsFetchingState {
  final String? message;
  const WishlistProductDetailsFetchingError(this.message);
}
