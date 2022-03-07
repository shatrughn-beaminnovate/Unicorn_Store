part of 'subcategory_api_fetch_bloc.dart';

abstract class SubcategoryApiFetchState extends Equatable {
  const SubcategoryApiFetchState();
  
  @override
  List<Object> get props => [];
}

class SubcategoryApiFetchInitial extends SubcategoryApiFetchState {}

class SubcategoryApiFetchLoading extends SubcategoryApiFetchState {}

class SubcategoryApiFetchLoaded extends SubcategoryApiFetchState {
  final SubCategoryList subcategory;

  const SubcategoryApiFetchLoaded(this.subcategory);
}

class SubcategoryApiFetchError extends SubcategoryApiFetchState {
  final String? message;
  const SubcategoryApiFetchError(this.message);
}