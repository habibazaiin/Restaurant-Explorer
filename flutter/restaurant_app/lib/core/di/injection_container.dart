import 'package:auth_app/features/restaurants/data/datasources/product_remote_datasource.dart';
import 'package:auth_app/features/restaurants/data/repositories/product_repository_impl.dart';
import 'package:auth_app/features/restaurants/domain/repositories/product_repository.dart';
import 'package:auth_app/features/restaurants/domain/usecases/get_products_usecase.dart';
import 'package:auth_app/features/restaurants/presentation/cubit/product/product_cubit.dart';
import 'package:auth_app/features/restaurants/presentation/cubit/restuarant/restaurant_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/restaurants/data/datasources/restaurant_remote_datasource.dart';
import '../../features/restaurants/data/repositories/restaurant_repository_impl.dart';
import '../../features/restaurants/domain/repositories/restaurant_repository.dart';
import '../../features/restaurants/domain/usecases/get_restaurants_usecase.dart';
import '../../features/search/data/datasources/search_remote_datasource.dart';
import '../../features/search/data/repositories/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/domain/usecases/search_restaurants_usecase.dart';
import '../../features/search/domain/usecases/search_restaurants_map_usecase.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ─── Auth ───────────────────────────────────────────
  sl.registerFactory(
    () => AuthCubit(loginUseCase: sl(), signupUseCase: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  // ─── Restaurants ────────────────────────────────────
  sl.registerFactory(
    () => RestaurantCubit(getRestaurantsUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetRestaurantsUseCase(sl()));
  sl.registerLazySingleton<RestaurantRepository>(
      () => RestaurantRepositoryImpl(sl()));
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
      () => RestaurantRemoteDataSourceImpl(sl()));

  // ─── Products ───────────────────────────────────────
  sl.registerFactory(
    () => ProductCubit(getProductsUseCase: sl()),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()));

  // ─── Search ─────────────────────────────────────────
  sl.registerFactory(
    () => SearchCubit(
      searchRestaurantsUseCase: sl(),
      searchRestaurantsMapUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => SearchRestaurantsUseCase(sl()));
  sl.registerLazySingleton(() => SearchRestaurantsMapUseCase(sl()));
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(sl()));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(sl()));

  // ─── External ───────────────────────────────────────
  sl.registerLazySingleton(() => Dio());
}