part of 'product_details_api_fetch_bloc.dart';

abstract class ProductDetailsApiFetchEvent extends Equatable {
  const ProductDetailsApiFetchEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetailsApiFetch extends ProductDetailsApiFetchEvent {
  final String productDetailsId;

  const LoadProductDetailsApiFetch({required this.productDetailsId});

  @override
  List<Object> get props => [productDetailsId];
}

