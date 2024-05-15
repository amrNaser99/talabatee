import 'package:talabatee/features/cart/presentation/screens/cart_screen.dart';
import 'package:talabatee/features/home/home_screen.dart';
import 'package:talabatee/features/order/presentation/pages/order_screen.dart';
import 'package:talabatee/features/splash/presentation/screens/splash_screen.dart';

var routes = {
  SplashScreen.route: (_) => const SplashScreen(),
  HomeScreen.route: (_) => const HomeScreen(),
  OrderScreen.route: (_) =>  const OrderScreen(),
  CartScreen.route: (_) => const CartScreen(),
};
