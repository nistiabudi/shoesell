import 'package:eshoes_clean_arch/core/network/network_info.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/cart_local_data_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/delivery_info_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/order_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/product_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/local/user_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/delivery_info_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/order_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/user_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/repositories/cart_repository_impl.dart';
import 'package:eshoes_clean_arch/data/repositories/delivery_info_impl.dart';
import 'package:eshoes_clean_arch/data/repositories/order_repository_impl.dart';
import 'package:eshoes_clean_arch/data/repositories/user_repository_impl.dart';
import 'package:eshoes_clean_arch/domain/repositories/cart_repository.dart';
import 'package:eshoes_clean_arch/domain/repositories/delivery_info_repository.dart';
import 'package:eshoes_clean_arch/domain/repositories/order_repository.dart';
import 'package:eshoes_clean_arch/domain/repositories/user_repository.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/add_cart_item_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/clear_item_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/get_cached_cart_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/cart/sync_cart_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/add_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/clear_local_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/edit_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/get_selected_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/delivery_info/select_delivery_info_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/add_order_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/clear_local_order_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/get_cached_orders_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/order/get_remote_orders_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/user/get_cached_user_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/user/sign_in_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/user/sign_out_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/user/sign_up_usecase.dart';
import 'package:eshoes_clean_arch/presentation/blocs/delivery_info/delivery_info_action/delivery_info_action_cubit.dart';
import 'package:eshoes_clean_arch/presentation/blocs/delivery_info/delivery_info_fetch/delivery_info_fetch_cubit.dart';
import 'package:eshoes_clean_arch/presentation/blocs/order/order_add/order_add_cubit.dart';
import 'package:eshoes_clean_arch/presentation/blocs/order/order_fetch/order_fetch_cubit.dart';
import 'package:eshoes_clean_arch/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:eshoes_clean_arch/data/data_sources/local/category_local_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/category_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/data_sources/remote/product_remote_data_source.dart';
import 'package:eshoes_clean_arch/data/repositories/category_repository_impl.dart';
import 'package:eshoes_clean_arch/data/repositories/product_repository_impl.dart';
import 'package:eshoes_clean_arch/domain/repositories/category_repository.dart';
import 'package:eshoes_clean_arch/domain/repositories/product_repository.dart';
import 'package:eshoes_clean_arch/domain/usecases/category/filter_category_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/category/get_cached_category_usecase.dart';
import 'package:eshoes_clean_arch/domain/usecases/category/get_remote_category_usecase.dart';
import 'package:eshoes_clean_arch/presentation/blocs/cart/cart_bloc.dart';
import 'package:eshoes_clean_arch/presentation/blocs/category/category_bloc.dart';
import 'package:eshoes_clean_arch/domain/usecases/product/get_product_usecase.dart';
import 'package:eshoes_clean_arch/presentation/blocs/product/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Product
  // BLoC
  sl.registerFactory(() => ProductBloc(sl()));
  // UseCases
  sl.registerLazySingleton(() => GetProductUseCase(sl()));
  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Datasources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Category
  // BLoC
  sl.registerFactory(
    () => CategoryBloc(sl(), sl(), sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedCategoryUseCase(sl()));
  sl.registerLazySingleton(() => FilterCategoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Datasources
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Cart
  // BLoC
  sl.registerFactory(
    () => CartBloc(sl(), sl(), sl(), sl()),
  );
  // usecase
  sl.registerLazySingleton(() => AddCartItemUseCase(sl()));
  sl.registerLazySingleton(() => ClearItemUseCase(sl()));
  sl.registerLazySingleton(() => SyncCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      userLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data Sources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataDataSource>(
    () => CartLocalDataDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Delivery Info
  // BLoC
  sl.registerFactory(() => DeliveryInfoActionCubit(sl(), sl(), sl()));
  sl.registerFactory(
    () => DeliveryInfoFetchCubit(sl(), sl(), sl(), sl()),
  );
  // UseCases
  sl.registerLazySingleton(() => GetRemoteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedCategoryUseCase(sl()));
  sl.registerLazySingleton(() => AddDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => EditDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => SelectDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetSelectedDeliveryInfoUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalDeliveryInfoUseCase(sl()));
  // repository
  sl.registerLazySingleton<DeliveryInfoRepository>(
    () => DeliveryInfoImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // DataSources
  sl.registerLazySingleton<DeliveryInfoRemoteDataSource>(
    () => DeliveryInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<DeliveryInfoLocalDataSource>(
    () => DeliveryInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );
  // Features - Order
  // BLoC
  sl.registerFactory(
    () => OrderAddCubit(sl()),
  );
  sl.registerFactory(
    () => OrderFetchCubit(sl(), sl(), sl()),
  );
  // use cases
  sl.registerLazySingleton(() => AddOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetRemoteOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedOrdersUseCase(sl()));
  sl.registerLazySingleton(() => ClearLocalOrderUseCase(sl()));
  // repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      userLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // DataSources
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - User
  // BLoC
  sl.registerFactory(
    () => UserBloc(
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  // UseCases
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  // repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data Sources
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(
        flutterSecureStorage: sl(), sharedPreferences: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );
  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
