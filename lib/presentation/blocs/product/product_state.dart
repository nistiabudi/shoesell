part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState(
      {required this.products, required this.metaData, required this.params});

  final List<Product> products;
  final PaginationMetaData metaData;
  final FliterProductParams params;
}

class ProductInitial extends ProductState {
  const ProductInitial({
    required super.metaData,
    required super.params,
    required super.products,
  });

  @override
  List<Object> get props => [];
}

class ProductEmpty extends ProductState {
  const ProductEmpty({
    required super.metaData,
    required super.params,
    required super.products,
  });

  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  const ProductLoading({
    required super.metaData,
    required super.params,
    required super.products,
  });

  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  const ProductLoaded({
    required super.metaData,
    required super.params,
    required super.products,
  });

  @override
  List<Object> get props => [];
}

class ProductFailure extends ProductState {
  final Failure failure;
  const ProductFailure({
    required super.metaData,
    required super.params,
    required super.products,
    required this.failure,
  });

  @override
  List<Object> get props => [];
}

class ProductError extends ProductState {
  final Failure failure;
  const ProductError({
    required this.failure,
    required super.metaData,
    required super.params,
    required super.products,
  });

  @override
  List<Object> get props => [];
}
