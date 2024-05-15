import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_fonts.dart';
import 'package:talabatee/core/utils/app_spaces.dart';
import 'package:talabatee/core/utils/size_config.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_cubit.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_state.dart';
import 'package:talabatee/features/cart/presentation/screens/cart_screen.dart';
import 'package:talabatee/features/order/domain/entities/product.dart';
import 'package:talabatee/res/assets_res.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showProductDetails(context, product),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image:
                          AssetImage(AssetsRes.PRODUCT_PATH + product.imgUrl),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      height: 1.4
                    ),
                    maxLines: 2,
                  
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: product.offerPrice != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price: ${product.price}',
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            'Offer Price: ${product.offerPrice}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    : Text('Price: ${product.price}'),
              ),
              TextButton(
                  onPressed: () => _showProductDetails(context, product),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(AppColors.greyColor),
                      shadowColor: MaterialStateProperty.all(Colors.grey)),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'اضافه الي السلة',
                        style: TextStyle(color: Colors.black),
                      ),
                      // AppSpaces.hSpace5,
                      Icon(
                        Ionicons.add_circle,
                        color: AppColors.primaryColor,
                        size: AppSize.s30,
                      ),
                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      // enableDrag: true,
      // isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => _productDetailsBuilder(context, product),
    );
  }

  Widget _productDetailsBuilder(BuildContext context, Product product) {
    // Assuming you have access to a cartBloc or cartProvider here that can provide cart total info
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          // height: SizeConfig.screenHeight! * 0.7,
          // height: MediaQuery.of(context).size.height * 0.8 - (kToolbarHeight * 2),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    AssetsRes.PRODUCT_PATH + product.imgUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  product.name,
                  style: TextStyle(
                      fontSize: FontSize.s24, fontWeight: FontWeight.bold),
                ),
                Text('السعر:  ${product.price} رس',
                    style: TextStyle(
                        fontSize: FontSize.s18, fontWeight: FontWeight.bold)),
                AppSpaces.vSpace16,
                Divider(
                  thickness: 4,
                  color: Colors.grey.shade300,
                ),
                Text(
                  '${"Description".tr()}',
                  style: TextStyle(fontSize: FontSize.s16),
                ),
                Text(
                  product.desc,
                  style: TextStyle(fontSize: FontSize.s16),
                ),
                AppSpaces.vSpace16,

                Divider(
                  thickness: 4,
                  color: Colors.grey.shade300,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('إجمالي العناصر: ${context.read<CartCubit>().getItems()}',
                              style: TextStyle(fontSize: FontSize.s16)),
                          Text('إجمالي السعر: ${state.totalPrice} رس',
                              style: TextStyle(fontSize: FontSize.s16)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Ionicons.remove_circle_outline),
                            onPressed: () => context
                                .read<CartCubit>()
                                .removeItem(product.id
                                    .toString()), // Adjust based on your state management
                          ),
                          // Text('${ }'),
                          // Display current quantity
                          IconButton(
                            icon: const Icon(Ionicons.add_circle_outline),
                            onPressed: () => context.read<CartCubit>().addItem(
                                product), // Adjust based on your state management
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       'اضافه الي السلة', // "Add to Cart" in Arabic
                //       style: TextStyle(color: Colors.black),
                //     ),
                    AppSpaces.vSpace16,
                //     Icon(
                //       Ionicons.add_circle,
                //       color: AppColors.primaryColor,
                //       size: AppSize.s30,
                //     ),
                //   ],
                // ),
                TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                      padding:  MaterialStateProperty.all(EdgeInsets.all(8))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'إالذهاب الي السلة', // "Add to Cart" in Arabic
                          style: TextStyle(color: Colors.white),
                        ),
                        AppSpaces.hSpace10,
                        Icon(
                          Ionicons.cart_outline,
                          color: AppColors.whiteColor,
                          size: AppSize.s30,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
