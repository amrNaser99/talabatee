import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:talabatee/blocs/app_cubit/app_state.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_const.dart';

class HomeScreen extends StatefulWidget {
  static const route = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController tabController;

  int currentNavIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize tabController for the PersistentTabView
    tabController = PersistentTabController(initialIndex: currentNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PersistentTabView(
          context,
          controller: tabController,
          screens: cubit.navScreens(),
          items: cubit.navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: AppColors.scaffoldBackgroundColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          bottomScreenMargin: 35,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            boxShadow: AppConst.shadow,
            borderRadius: BorderRadius.circular(AppConst.borderRadius),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.

            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style14,
        );
      },
    );
  }
}
