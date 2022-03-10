import 'package:unicorn_store/Data/Data_Providers/Category/subcategory_service_api.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/Accessories%20product%20Wishlist/accessories_wishlist_product_details.dart';

class SubCategoryRepository {
  final _subCategoryServiceApi = SubCategoryServiceApi();
  Future<SubCategoryList> getSubCategories(String categoryId) {
    return _subCategoryServiceApi.getSubCategories(categoryId);
  }

  Future<AccessoriesListData> getAccessoriesCategoryData(String categoryId,String token) {
    return _subCategoryServiceApi.getAccessoriesCategoryData(categoryId,token);
  }

  //This will load Accessories Product Details
  Future<AccessoriesWishlistProductDetails> getAccessoriesProductDetails(
      String productId,String token) {
    return _subCategoryServiceApi.getAccessoriesProductDetails(productId,token);
  }
}
