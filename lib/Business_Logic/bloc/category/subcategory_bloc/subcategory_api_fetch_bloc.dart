import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory/subcategory_list.dart';
import 'package:unicorn_store/Data/Repositories/category/subcategory_repository.dart';
part 'subcategory_api_fetch_event.dart';
part 'subcategory_api_fetch_state.dart';

class SubcategoryApiFetchBloc
    extends Bloc<SubcategoryApiFetchEvent, SubcategoryApiFetchState> {
  SubcategoryApiFetchBloc() : super(SubcategoryApiFetchInitial()) {
    final SubCategoryRepository _subcategoryRepository =
        SubCategoryRepository();

    on<LoadSubcategoryApiFetch>((event, emit) async {
      try {
        emit(SubcategoryApiFetchLoading());
        final _subCategory =
            await _subcategoryRepository.getSubCategories(event.subCategoryId);
        emit(SubcategoryApiFetchLoaded(_subCategory));
      } catch (e) {
        emit(SubcategoryApiFetchError(e.toString()));
      }
    });
  }
}
