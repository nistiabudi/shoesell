import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';

import '../../../domain/entities/product/pagination_meta_data.dart';
import '../../../domain/entities/product/product.dart';
import '../../../domain/usecases/product/get_product_usecase.dart';

part 'product_state.dart';
part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductUseCase _getProductUseCase;
  ProductBloc(this._getProductUseCase)
      : super(ProductInitial(
            products: const [],
            params: const FliterProductParams(),
            metaData: PaginationMetaData(
              limit: 0,
              pageSize: 20,
              total: 0,
            ))) {
    on<GetProducts>(_onLoadProducts);
    on<GetMoreProducts>(_onLoadMoreProducts);
  }

  void _onLoadProducts(GetProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading(
        params: event.params,
        products: const [],
        metaData: state.metaData,
      ));
      final result = await _getProductUseCase(event.params);
      result.fold(
        (failure) => emit(ProductError(
            failure: failure,
            metaData: state.metaData,
            params: event.params,
            products: const [])),
        (productResponse) => emit(ProductLoaded(
          metaData: productResponse.paginationMetaData,
          params: event.params,
          products: productResponse.products,
        )),
      );
    } catch (e) {
      emit(ProductError(
        failure: ExceptionFailure(),
        metaData: state.metaData,
        params: event.params,
        products: state.products,
      ));
    }
  }

  void _onLoadMoreProducts(
      GetMoreProducts event, Emitter<ProductState> emit) async {
    var state = this.state;
    var limit = state.metaData.limit;
    var total = state.metaData.total;
    var loadedProductsLength = state.products.length;
    if (state is ProductLoaded && (loadedProductsLength < total)) {
      try {
        emit(ProductLoading(
          metaData: state.metaData,
          params: state.params,
          products: const [],
        ));
        final result =
            await _getProductUseCase(FliterProductParams(limit: limit + 10));
        result.fold(
            (failure) => emit(ProductError(
                failure: failure,
                metaData: state.metaData,
                params: state.params,
                products: state.products)), (productResponse) {
          List<Product> products = state.products;
          products.addAll(productResponse.products);
          emit(
            ProductLoaded(
              metaData: state.metaData,
              params: state.params,
              products: products,
            ),
          );
        });
      } catch (e) {
        emit(ProductError(
          products: state.products,
          params: state.params,
          metaData: state.metaData,
          failure: ExceptionFailure(),
        ));
      }
    }
  }
}
