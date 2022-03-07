

import 'package:unicorn_store/Data/Data_Providers/My%20Account/Wishlist/wishlist_product_details_api.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/product%20add%20or%20delete%20response/product_add_delete_response.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/wishlist_details.dart';

class WishlistProductDetailsRepository
{

    final _wishlistDetailsProductApi = WishlistDetailsProductApi();

    //Load Customer list of address
  Future<WishlistDetails> getWishlistProductDetails(String customerID,String token) {
    return _wishlistDetailsProductApi.getWishlistProductDetails(customerID,token);
  }

    //Add or delete product from wishlist
  Future<ProductAddDeleteResponse> addOrDeleteWishlistProduct(String customerID,String productId,String token) {
    return _wishlistDetailsProductApi.addOrDeleteWishlistProduct(customerID, productId, token);
  }




}