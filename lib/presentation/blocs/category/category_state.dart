part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState({required this.categories});
  final List<Category> categories;
}

class CategoryInitial extends CategoryState {
  const CategoryInitial({required super.categories});

  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading({required super.categories});

  @override
  List<Object> get props => [];
}

class CategoryCachedLoaded extends CategoryState {
  const CategoryCachedLoaded({required super.categories});

  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded({required super.categories});

  @override
  List<Object> get props => [];
}

class CategoryError extends CategoryState {
  const CategoryError({
    required this.failure,
    required super.categories,
  });
  final Failure failure;

  @override
  List<Object> get props => [failure];
}
