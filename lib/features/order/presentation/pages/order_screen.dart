import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:talabatee/blocs/app_cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabatee/core/utils/app_const.dart';
import 'package:talabatee/core/utils/app_fonts.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_cubit.dart';
import 'package:talabatee/features/order/domain/entities/categories.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/features/order/presentation/widgets/product_card.dart';
import 'package:talabatee/res/assets_res.dart';

class OrderScreen extends StatefulWidget {
  static const route = 'OrderScreenRoute';

  const OrderScreen({super.key});

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _retryCount = 0;
  final int _maxRetryCount = 3;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    await context.read<AppCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetCategoriesFailed) {
          if (_retryCount < _maxRetryCount) {
            Future.delayed(Duration(seconds: 2), _fetchCategories);
            _retryCount++;
          }
        }
        if (state is GetCategoriesSuccess) {
          _initializeOrReinitializeTabController(state.categories.length);
        }
      },
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'categories',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FontSize.s20,
                  fontFamily: FontFamily.fontFamily),
            ).tr(),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Implement search functionality
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              tabs: context
                  .watch<AppCubit>()
                  .categories
                  .map((category) => Tab(text: category.name))
                  .toList(),
            ),
          ),
          body: context.watch<AppCubit>().categories != []
              ? TabBarView(
                  controller: _tabController,
                  children: context
                      .watch<AppCubit>()
                      .categories
                      .map((category) =>
                          CategoryProductsWidget(category: category))
                      .toList(),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  void _initializeOrReinitializeTabController(int length) {
    if (_tabController == null || _tabController!.length != length) {
      _tabController?.dispose(); // Dispose of the old controller if it exists
      _tabController = TabController(length: length, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}

class CategoryProductsWidget extends StatefulWidget {
  final Categories category;

  const CategoryProductsWidget({super.key, required this.category});

  @override
  State<CategoryProductsWidget> createState() => _CategoryProductsWidgetState();
}

class _CategoryProductsWidgetState extends State<CategoryProductsWidget> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Log the fetch action
      products = await context
          .read<AppCubit>()
          .getProductsByCategoryId(categoryId: widget.category.id.toString());
      print('Fetching products for category ID: ${widget.category.id}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GetProductByCategoriesIdFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load products: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        if (state is GetProductByCategoriesIdLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        // else
        //   if (state is GetProductByCategoriesIdSuccess &&
        //     state.categoryId == widget.category.id.toString()) {
        // if (state.products.isEmpty) {
        //   return const Center(child: Text('No products found'));
        // }
        return ProductsGridView(products: products);
        // }
        // else {
        //   // Log the state mismatch or unexpected state
        //   print(
        //       'Current state does not match expected success state or is still loading.');
        //   return Center(child: Text('Unable to load products'));
        // }
      },
    );
  }
}

class ProductsGridView extends StatelessWidget {
  final List<Product> products;

  const ProductsGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 4, // Horizontal space between cards
        mainAxisSpacing: 4, // Vertical space between cards
        childAspectRatio: 0.8, // Aspect ratio of each card
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onAddToCart: () => cartCubit.addItem(products[index]),
        );
      },
    );
  }
}
