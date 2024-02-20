import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:eshoes_clean_arch/core/usecases/usecase.dart';

import 'package:eshoes_clean_arch/domain/usecases/category/filter_category_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/category/get_cached_category_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/category/get_remote_category_usecase.dart';

import '../../../domain/entities/category/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetRemoteCategoryUseCase _getRemoteCategoryUseCase;
  final GetCachedCategoryUseCase _getCachedCategoryUseCase;
  final FilterCategoryUseCase _filterCategoryUseCase;
  CategoryBloc(this._getRemoteCategoryUseCase, this._getCachedCategoryUseCase,
      this._filterCategoryUseCase)
      : super(const CategoryLoading(categories: [])) {
    on<GetCategories>(_onLoadCategories);
    on<FilterCategories>(_onFilterCategories);
  }

  void _onLoadCategories(
      GetCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(const CategoryLoading(categories: []));
      final cachedResult = await _getCachedCategoryUseCase(NoParams());
      cachedResult.fold(
        (failure) => (),
        (categories) => emit(CategoryCachedLoaded(
          categories: categories,
        )),
      );
      final result = await _getRemoteCategoryUseCase(NoParams());
      result.fold(
        (failure) => emit(CategoryError(
          failure: failure,
          categories: state.categories,
        )),
        (categories) => emit(CategoryLoaded(
          categories: categories,
        )),
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(CategoryError(
        categories: state.categories,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onFilterCategories(
      FilterCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading(categories: state.categories));
      final cachedResult = await _filterCategoryUseCase(event.keyword);
      cachedResult.fold(
        (failure) => emit(CategoryError(
          failure: failure,
          categories: state.categories,
        )),
        (categories) => emit(CategoryLoaded(
          categories: categories,
        )),
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(CategoryError(
        failure: ExceptionFailure(),
        categories: state.categories,
      ));
    }
  }
}
