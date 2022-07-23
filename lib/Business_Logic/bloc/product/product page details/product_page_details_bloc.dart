import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Data/Repositories/product/product_details_repository.dart';

part 'product_page_details_event.dart';
part 'product_page_details_state.dart';

class ProductPageDetailsBloc extends Bloc<ProductPageDetailsEvent, ProductPageDetailsState> {
  ProductPageDetailsBloc() : super(ProductPageDetailsInitial()) {

    final ProductDetailsRepository productDetailsRepository=ProductDetailsRepository();

    on<LoadProductDataBasedOnValueEvent>((event, emit) async{
       try {
        emit(ProductPageDetailsLoading());
        final productPageDetails = await productDetailsRepository
            .getProductPageDetails(event.productValue,event.productId,event.token);
             await Future.delayed(const Duration(seconds: 2));
        emit(ProductPageDetailsLoaded(productPageDetails));
      } catch (e) {
        emit(ProductPageDetailsError(e.toString()));
      }
    });
  }
}
