import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_store/Data/Models/Category/Subcategory_Types/subcategory_types_list.dart';
import 'package:unicorn_store/Data/Repositories/category/subcategory_types_repository.dart';
part 'subcategory_types_api_fetch_event.dart';
part 'subcategory_types_api_fetch_state.dart';

class SubcategoryTypesApiFetchBloc
    extends Bloc<SubcategoryTypesApiFetchEvent, SubcategoryTypesApiFetchState> {
  SubcategoryTypesApiFetchBloc() : super(SubcategoryTypesApiFetchInitial()) {
    final SubcategoryTypesRepository subcategoryTypesRepository =
        SubcategoryTypesRepository();

    on<LoadSubcategoryTypesApiFetch>((event, emit) async {
      try {
        emit(SubcategoryTypesApiFetchLoading());
        final subcategoryTypes = await subcategoryTypesRepository
            .getSubcategoriesTypes(event.subCategoryTypesId);
        await Future.delayed(const Duration(seconds: 2));
        emit(SubcategoryTypesApiFetchLoaded(subcategoryTypes));
      } catch (e) {
        emit(SubcategoryTypesApiFetchError(e.toString()));
      }
    });
  }
}
