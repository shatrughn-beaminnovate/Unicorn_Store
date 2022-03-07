import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/Category/category.dart';
import 'package:unicorn_store/Data/Repositories/category/category_respository.dart';

part 'category_api_fetch_event.dart';
part 'category_api_fetch_state.dart';

class CategoryApiFetchBloc
    extends Bloc<CategoryApiFetchEvent, CategoryApiFetchState> {
  CategoryApiFetchBloc() : super(CategoryApiFetchInitial()) {
    final CategoryRepository _categoryRepository = CategoryRepository();

    on<LoadCategoryApiFetch>((event, emit) async {
      try {
        emit(CategoryApiFetchLoading());
        final _category = await _categoryRepository.getCategories();
        emit(CategoryApiFetchLoaded(_category));
      } catch (e) {
        emit(CategoryApiFetchError(e.toString()));
      }
    });
  }
}
