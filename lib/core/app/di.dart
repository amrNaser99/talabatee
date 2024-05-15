import 'package:get_it/get_it.dart';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:talabatee/features/cart/data/repositories/cart_repo_impl.dart';
import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';
import 'package:talabatee/features/cart/domain/use_cases/add_item_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/get_total_items_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/get_total_price_use_case.dart';
import 'package:talabatee/features/cart/domain/use_cases/remove_item_use_case.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_cubit.dart';
import 'package:talabatee/features/order/data/repositories/oder_repo_impl.dart';
import 'package:talabatee/features/order/domain/repositories/order_repo.dart';
import 'package:talabatee/features/order/domain/use_cases/get_categories_use_case.dart';
import 'package:talabatee/features/order/domain/use_cases/get_product_by_categort_id_use_case.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  // Register repositories
  sl.registerLazySingleton<OrderRepo>(() => OrderRepoImpl());
  sl.registerLazySingleton<CartRepo>(() => CartRepoImpl());

  // Register Order UseCases
  sl.registerLazySingleton(() => GetCategoriesUseCase(orderRepo: sl()));
  sl.registerLazySingleton(
      () => GetProductByCategoryIdUseCase(orderRepo: sl()));

  // Register Cart UseCases
  sl.registerLazySingleton(() => AddItemUseCase(cartRepo: sl()));
  sl.registerLazySingleton(() => RemoveItemUseCase(cartRepo: sl()));
  sl.registerLazySingleton(() => GetTotalPriceUseCase(cartRepo: sl()));
  sl.registerLazySingleton(() => GetItemsUseCase(cartRepo: sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(cartRepo: sl()));

  // Register App Cubit
  sl.registerFactory(
    () => AppCubit(
      getCategoriesUseCase: sl(),
      getProductByCategoryIdUseCase: sl(),
    ),
  );

  // Register Cart Cubit
  sl.registerFactory(
    () => CartCubit(
      addItemUseCase: sl(),
      removeItemUseCase: sl(),
      getTotalPriceUseCase: sl(),
      getItemsUseCase: sl(),

      clearCartUseCase: sl(),
    ),
  );
}
