// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/Category/AccessoriesCategory/accessories_list_data.dart';
import 'package:unicorn_store/Data/Models/MyAccount/Wishlist/Accessories%20product%20Wishlist/accessories_wishlist_product_details.dart';
import 'package:unicorn_store/Data/Repositories/category/subcategory_repository.dart';

part 'accessories_data_fetch_event.dart';
part 'accessories_data_fetch_state.dart';

class AccessoriesDataFetchBloc
    extends Bloc<AccessoriesDataFetchEvent, AccessoriesDataFetchState> {
  AccessoriesDataFetchBloc() : super(AccessoriesDataFetchInitial()) {
    final SubCategoryRepository subcategoryRepository =
        SubCategoryRepository();

    on<LoadAccessoriesDataFetch>((event, emit) async {
      try {
        //emit(AccessoriesDataFetchLoading());
        final accessoriesData = await subcategoryRepository
            .getAccessoriesCategoryData(event.subCategoryId);

        emit(AccessoriesDataFetchLoaded(accessoriesData));
      } catch (e) {
        emit(AccessoriesDataFetchError(e.toString()));
      }
    });

    on<LoadAccessoriesProductDetailsFetch>((event, emit) async {
      try {
        emit(AccessoriesDataFetchLoading());
        final accessoriesData = await subcategoryRepository
            .getAccessoriesProductDetails(event.productId,event.token);
        await Future.delayed(const Duration(seconds: 2));
        emit(AccessoriesProductDetailsFetchSuccess(accessoriesData));
      } catch (e) {
        emit(AccessoriesDataFetchError(e.toString()));
      }
    });
  }
}
