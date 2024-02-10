import 'package:eshoes_clean_arch/domain/entities/product/pagination_meta_data.dart';
import 'package:eshoes_clean_arch/domain/entities/product/product.dart';

class ProductResponse {
  ProductResponse({
    required this.products,
    required this.paginationMetaData,
  });
  final List<Product> products;
  final PaginationMetaData paginationMetaData;
}
