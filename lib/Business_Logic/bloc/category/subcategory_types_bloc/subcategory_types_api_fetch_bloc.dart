import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory_Types/subcategory_types_list.dart';
import 'package:unicorn_store/Data/Repositories/category/subcategory_types_repository.dart';
part 'subcategory_types_api_fetch_event.dart';
part 'subcategory_types_api_fetch_state.dart';

class SubcategoryTypesApiFetchBloc
    extends Bloc<SubcategoryTypesApiFetchEvent, SubcategoryTypesApiFetchState> {
  SubcategoryTypesApiFetchBloc() : super(SubcategoryTypesApiFetchInitial()) {
    final SubcategoryTypesRepository _subcategoryTypesRepository =
        SubcategoryTypesRepository();

    on<LoadSubcategoryTypesApiFetch>((event, emit) async {
      try {
        emit(SubcategoryTypesApiFetchLoading());
        final _subcategoryTypes = await _subcategoryTypesRepository
            .getSubcategoriesTypes(event.subCategoryTypesId);

        emit(SubcategoryTypesApiFetchLoaded(_subcategoryTypes));
      } catch (e) {
        emit(SubcategoryTypesApiFetchError(e.toString()));
      }
    });
  }
}
