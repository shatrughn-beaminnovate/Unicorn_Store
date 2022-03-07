import 'package:unicorn_store/Data/Data_Providers/category/category_service_api.dart';
import 'package:unicorn_store/Data/Models/Category/category.dart';

class CategoryRepository {
  final _categoryServiceApi = CategoryServiceApi();
  Future<Category> getCategories() {
    return _categoryServiceApi.getCategories();
  }
}
