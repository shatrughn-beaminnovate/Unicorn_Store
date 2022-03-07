import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Page/product_page_details.dart';
import 'package:unicorn_store/Data/Models/Product/Product%20Type/type_details.dart';
import 'package:unicorn_store/Data/Repositories/product/product_details_repository.dart';

part 'product_details_api_fetch_event.dart';
part 'product_details_api_fetch_state.dart';

class ProductDetailsApiFetchBloc extends Bloc<ProductDetailsApiFetchEvent, ProductDetailsApiFetchState> {
  ProductDetailsApiFetchBloc() : super(ProductDetailsApiFetchInitial()) {

    final ProductDetailsRepository _productDetailsRepository=ProductDetailsRepository();
    
    on<LoadProductDetailsApiFetch>((event, emit) async{
       try {
        emit(ProductDetailsApiFetchLoading());
        final _productDetails = await _productDetailsRepository
            .getProductDetails(event.productDetailsId);

        emit(ProductDetailsApiFetchLoaded(_productDetails));
      } catch (e) {
        emit(ProductDetailsApiFetchError(e.toString()));
      }
    });

  
  }
}
