import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:talabatee/core/app/app.dart';
import 'package:talabatee/core/app/di.dart';
import 'package:talabatee/core/utils/bloc_observer.dart';
import 'package:talabatee/core/utils/localization.dart';
import 'package:talabatee/features/cart/domain/repositories/cart_repo.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_cubit.dart';
import 'package:talabatee/services/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  HttpOverrides.global = MyHttpOverrides();
  setupLocator();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    EasyLocalization(
      supportedLocales: Localization.locales,
      path: 'assets/translation',
      fallbackLocale: Localization.defaultLocale,
      startLocale: Localization.defaultLocale,
      saveLocale: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
              getCategoriesUseCase: sl(),
              getProductByCategoryIdUseCase: sl(),
            ),
          ),
          BlocProvider<CartCubit>(
            create: (context) => CartCubit(
              addItemUseCase: sl(),
              removeItemUseCase: sl(),
              clearCartUseCase: sl(),
              getTotalPriceUseCase: sl(),
              getItemsUseCase: sl(),
            ),
          ),
        ],
        child: const TalabateeApp(),
      ),
    ),
  );
}
