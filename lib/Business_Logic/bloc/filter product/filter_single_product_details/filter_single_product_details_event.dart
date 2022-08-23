part of 'filter_single_product_details_bloc.dart';

abstract class FilterSingleProductDetailsEvent extends Equatable {
  const FilterSingleProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadFilterSingleProductDetails extends FilterSingleProductDetailsEvent {
  final String productSlug;

  const LoadFilterSingleProductDetails(this.productSlug);

   @override
  List<Object> get props => [productSlug];
}
