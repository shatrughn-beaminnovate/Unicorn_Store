part of 'product_page_details_bloc.dart';

abstract class ProductPageDetailsState extends Equatable {
  const ProductPageDetailsState();
  
  @override
  List<Object> get props => [];
}

class ProductPageDetailsInitial extends ProductPageDetailsState {}

class ProductPageDetailsLoading extends ProductPageDetailsState {}

class ProductPageDetailsLoaded extends ProductPageDetailsState {
  final dynamic productPageDetail;

  const ProductPageDetailsLoaded(this.productPageDetail);
}

class ProductPageDetailsError extends ProductPageDetailsState {
  final String? message;
  const ProductPageDetailsError(this.message);
}