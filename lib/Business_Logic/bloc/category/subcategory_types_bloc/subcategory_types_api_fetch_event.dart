part of 'subcategory_types_api_fetch_bloc.dart';

abstract class SubcategoryTypesApiFetchEvent extends Equatable {
  const SubcategoryTypesApiFetchEvent();

  @override
  List<Object> get props => [];
}

class LoadSubcategoryTypesApiFetch extends SubcategoryTypesApiFetchEvent {
  final String subCategoryTypesId;

  const LoadSubcategoryTypesApiFetch({required this.subCategoryTypesId});

  @override
  List<Object> get props => [subCategoryTypesId];
}
