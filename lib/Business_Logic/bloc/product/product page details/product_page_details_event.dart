part of 'product_page_details_bloc.dart';

abstract class ProductPageDetailsEvent extends Equatable {
  const ProductPageDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDataBasedOnValueEvent extends ProductPageDetailsEvent {
  final Map<String,String> productValue;
  final String productId;
  final String token;

  const LoadProductDataBasedOnValueEvent({required this.productValue,required this.productId,required this.token});

  @override
  List<Object> get props => [productValue,productId];
}