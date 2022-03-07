import 'package:unicorn_store/Data/Data_Providers/Category/subcategory_service_types_api.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory_Types/subcategory_types_list.dart';

class SubcategoryTypesRepository {
  final _subcategoryTypesServiceApi = SubcategoryTypesServiceApi();
  Future<SubcategoryTypesList> getSubcategoriesTypes(String subcategoryTypesId) {
    return _subcategoryTypesServiceApi
        .getSubcategoriesTypes(subcategoryTypesId);
  }
}
