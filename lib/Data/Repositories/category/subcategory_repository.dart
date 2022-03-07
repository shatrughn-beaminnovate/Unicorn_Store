import 'package:unicorn_store/Data/Data_Providers/category/subcategory_service_api.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';

class SubCategoryRepository {
  final _subCategoryServiceApi = SubCategoryServiceApi();
  Future<SubCategoryList> getSubCategories(String categoryId) {
    return _subCategoryServiceApi.getSubCategories(categoryId);
  }

  Future<AccessoriesListData> getAccessoriesCategoryData(String categoryId)
  {
         return _subCategoryServiceApi.getAccessoriesCategoryData(categoryId);
  }

}
