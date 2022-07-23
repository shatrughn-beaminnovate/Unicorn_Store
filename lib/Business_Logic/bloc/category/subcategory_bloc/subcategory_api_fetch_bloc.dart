import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';
import 'package:unicorn_store/Data/Repositories/category/subcategory_repository.dart';
part 'subcategory_api_fetch_event.dart';
part 'subcategory_api_fetch_state.dart';

class SubcategoryApiFetchBloc
    extends Bloc<SubcategoryApiFetchEvent, SubcategoryApiFetchState> {
  SubcategoryApiFetchBloc() : super(SubcategoryApiFetchInitial()) {
    final SubCategoryRepository subcategoryRepository =
        SubCategoryRepository();

    on<LoadSubcategoryApiFetch>((event, emit) async {
      try {
        emit(SubcategoryApiFetchLoading());
        final subCategory =
            await subcategoryRepository.getSubCategories(event.subCategoryId);
        emit(SubcategoryApiFetchLoaded(subCategory));
      } catch (e) {
        emit(SubcategoryApiFetchError(e.toString()));
      }
    });
  }
}
