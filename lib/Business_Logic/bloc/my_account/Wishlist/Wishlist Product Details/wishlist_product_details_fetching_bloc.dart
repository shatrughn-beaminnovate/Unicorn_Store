import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/product%20add%20or%20delete%20response/product_add_delete_response.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/wishlist_details.dart';
import 'package:unicorn_store/Data/Repositories/my_account/Wishlist/wishlist_product_details_repository.dart';

part 'wishlist_product_details_fetching_event.dart';
part 'wishlist_product_details_fetching_state.dart';

class WishlistProductDetailsFetchingBloc extends Bloc<
    WishlistProductDetailsFetchingEvent, WishlistProductDetailsFetchingState> {
  WishlistProductDetailsFetchingBloc()
      : super(WishlistProductDetailsFetchingInitial()) {
    final WishlistProductDetailsRepository _wishlistProductDetailsRepository =
        WishlistProductDetailsRepository();

    on<LoadWishlistProductDetailsApiFetch>((event, emit) async {
      try {
        emit(WishlistProductDetailsFetchingLoading());

        final _wishlistProductDetails = await _wishlistProductDetailsRepository
            .getWishlistProductDetails(event.customerId, event.token);

        emit(WishlistProductDetailsFetchingLoaded(_wishlistProductDetails));
      } catch (e) {
        emit(WishlistProductDetailsFetchingError(e.toString()));
      }
    });


    on<AddOrDeleteProductFromWishlistEvent>((event, emit) async {
      try {
        emit(WishlistProductDetailsFetchingLoading());

        final _addOrRemoveProductFromWishlist = await _wishlistProductDetailsRepository
            .addOrDeleteWishlistProduct(event.customerId, event.productId, event.token);

        emit(AddOrRemoveProductFromWishlistSuccess(_addOrRemoveProductFromWishlist));

      } catch (e) {
        emit(WishlistProductDetailsFetchingError(e.toString()));
      }
    });
  }
}
