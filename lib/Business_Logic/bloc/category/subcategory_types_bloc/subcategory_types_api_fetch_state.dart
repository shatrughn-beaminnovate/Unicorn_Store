part of 'subcategory_types_api_fetch_bloc.dart';

abstract class SubcategoryTypesApiFetchState extends Equatable {
  const SubcategoryTypesApiFetchState();
  
  @override
  List<Object> get props => [];
}

class SubcategoryTypesApiFetchInitial extends SubcategoryTypesApiFetchState {}

class SubcategoryTypesApiFetchLoading extends SubcategoryTypesApiFetchState {}

class SubcategoryTypesApiFetchLoaded extends SubcategoryTypesApiFetchState {
  final SubcategoryTypesList subcategoryTypes;

  const SubcategoryTypesApiFetchLoaded(this.subcategoryTypes);
}

class SubcategoryTypesApiFetchError extends SubcategoryTypesApiFetchState {
  final String? message;
  const SubcategoryTypesApiFetchError(this.message);
}
