part of 'accessories_data_fetch_bloc.dart';

abstract class AccessoriesDataFetchEvent extends Equatable {
  const AccessoriesDataFetchEvent();

  @override
  List<Object> get props => [];
}

class LoadAccessoriesDataFetch extends AccessoriesDataFetchEvent {
  final String subCategoryId;
 

  const LoadAccessoriesDataFetch({required this.subCategoryId});

  @override
  List<Object> get props => [subCategoryId];
}

class LoadAccessoriesProductDetailsFetch extends AccessoriesDataFetchEvent {
  final String productId;
  final String token;

  const LoadAccessoriesProductDetailsFetch({required this.productId,required this.token});

  @override
  List<Object> get props => [productId,token];
}
