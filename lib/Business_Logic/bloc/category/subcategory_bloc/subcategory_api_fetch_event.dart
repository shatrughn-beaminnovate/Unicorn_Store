part of 'subcategory_api_fetch_bloc.dart';

abstract class SubcategoryApiFetchEvent extends Equatable {
  const SubcategoryApiFetchEvent();

  @override
  List<Object> get props => [];
}

class LoadSubcategoryApiFetch extends SubcategoryApiFetchEvent {
  final String subCategoryId;

  const LoadSubcategoryApiFetch({required this.subCategoryId});

  @override
  List<Object> get props => [subCategoryId];
}
