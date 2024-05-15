import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:talabatee/core/utils/app_fonts.dart';
import 'package:talabatee/core/utils/app_spaces.dart';
import 'package:talabatee/core/utils/size_config.dart';
import 'package:talabatee/features/cart/domain/entities/cart_item.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_cubit.dart';
import 'package:talabatee/features/cart/presentation/manager/cart_state.dart';

class CartScreen extends StatelessWidget {
  static const route = 'CartScreenRoute';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'السلة',
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
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return emptyCartWidget();
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      itemCount: state.items.length,
                      itemBuilder: (ctx, index) {
                        String key = state.items.keys.elementAt(index);
                        CartItem item = state.items[key]!;
                        log("itemmm ${item}");
                        return ListTile(
                          leading: CircleAvatar(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: FittedBox(
                                child: Text(
                                    '\$${item.product.price.toStringAsFixed(2)}'),
                              ),
                            ),
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                              'Total: \$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () => context
                                    .read<CartCubit>()
                                    .removeItem(item.product.id.toString()),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    context.read<CartCubit>().addItem(item.product),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                onPressed: () => context.read<CartCubit>().checkout(),
                                child: Text('Checkout'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

        ],
      ),
    );
  }

  emptyCartWidget() => SizedBox(
    height: SizeConfig.screenHeight! * 0.8,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.cartShopping,
          size: AppSize.s50,
          applyTextScaling: true,
        ),
        AppSpaces.vSpace30,
        Text(
          "لا شئ في السلة حتي الان ",
          style: TextStyle(
            fontSize: AppSize.s20,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpaces.vSpace20,
        Text(
          "البحث عن المنتحات بالاسم أو التصفح حسب الفئة",
          style: TextStyle(
            fontSize: AppSize.s16,
            fontWeight: FontWeightManager.light,
          ),
        ),
        AppSpaces.vSpace10,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "تصفح",
                style: TextStyle(
                  fontSize: AppSize.s16,
                  fontWeight: FontWeightManager.light,
                ),
              )),
        )
      ],
    ),
  );
}
