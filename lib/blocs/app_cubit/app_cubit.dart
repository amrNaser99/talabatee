import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_fonts.dart';
import 'package:talabatee/core/utils/app_spaces.dart';
import 'package:talabatee/features/WheelSpinning/presentation/pages/wheel_spinning_screen.dart';
import 'package:talabatee/features/cart/presentation/screens/cart_screen.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/domain/use_cases/get_categories_use_case.dart';
import 'package:talabatee/features/order/domain/use_cases/get_product_by_categort_id_use_case.dart';
import 'package:talabatee/features/order/presentation/pages/order_screen.dart';
import 'package:talabatee/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabatee/blocs/app_cubit/app_state.dart';
import 'package:talabatee/services/cache_helper.dart';
import 'package:logger/logger.dart';

class AppCubit extends Cubit<AppState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductByCategoryIdUseCase getProductByCategoryIdUseCase;

  // Constructor for the AppCubit class
  AppCubit({
    required this.getCategoriesUseCase,
    required this.getProductByCategoryIdUseCase,
  }) : super(AppInitial());

  // Static method to get an instance of HomeCubit using the context
  static AppCubit get(context) => BlocProvider.of(context);

  List<Categories> categories = [];

  // Method to fetch categories
  Future<void> getCategories() async {
    try {
      emit(GetCategoriesLoading());
      categories = await getCategoriesUseCase.execute();
      emit(GetCategoriesSuccess(categories: categories));
    } catch (e) {
      emit(GetCategoriesFailed(error: e.toString()));
    }
  }

  // Method to fetch products by category ID
  Future<List<Product>> getProductsByCategoryId(
      {required String categoryId}) async {
    try {
      emit(GetProductByCategoriesIdLoading());
      final products =
          await getProductByCategoryIdUseCase.execute(categoryId: categoryId);
      emit(GetProductByCategoriesIdSuccess(
          products: products, categoryId: categoryId));
      return products;
    } catch (e) {
      emit(GetProductByCategoriesIdFailed(error: e.toString()));
      return [];
    }
  }

  List<Widget> navScreens() => const [
        OrderScreen(),
        CartScreen(),
        WheelSpinningScreen(),
      ];

  List<PersistentBottomNavBarItem> navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
            size: AppSize.s30,
          ),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Ionicons.cart,
            size: AppSize.s30,
          ),
          // iconSize: AppSize.s30,
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          textStyle: TextStyle(
            fontSize: AppSize.s20,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Ionicons.gift,
            size: AppSize.s30,
          ),
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
}
