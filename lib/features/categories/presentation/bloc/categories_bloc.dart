import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCases/get_categories_usecase.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesBloc({required this.getCategoriesUseCase})
      : super(CategoriesInitialState()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoriesLoadingState());
      final result = await getCategoriesUseCase.execute();
      result.fold(
        (failure) => emit(CategoriesErrorState(failure.errorMessage)),
        (categories) => emit(CategoriesSuccessState(categories: categories)),
      );
    });
    on<SelectCategoryEvent>((event, emit) {
      final currentState = state;

      if (currentState is CategoriesSuccessState) {
        emit(
          CategoriesSuccessState(
            categories: currentState.categories,
            selectedCategory: event.category,
          ),
        );
      }
    });
  }
}
