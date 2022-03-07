import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Repositories/product/product_details_repository.dart';

part 'product_page_details_event.dart';
part 'product_page_details_state.dart';

class ProductPageDetailsBloc extends Bloc<ProductPageDetailsEvent, ProductPageDetailsState> {
  ProductPageDetailsBloc() : super(ProductPageDetailsInitial()) {

    final ProductDetailsRepository _productDetailsRepository=ProductDetailsRepository();

    on<LoadProductDataBasedOnValueEvent>((event, emit) async{
       try {
        emit(ProductPageDetailsLoading());
        final _productPageDetails = await _productDetailsRepository
            .getProductPageDetails(event.productValue,event.productId);
        emit(ProductPageDetailsLoaded(_productPageDetails));
      } catch (e) {
        emit(ProductPageDetailsError(e.toString()));
      }
    });
  }
}
