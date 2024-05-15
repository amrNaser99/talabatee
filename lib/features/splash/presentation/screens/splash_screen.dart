import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/size_config.dart';
import 'package:talabatee/features/home/home_screen.dart';
import 'package:talabatee/features/order/presentation/pages/order_screen.dart';
import 'package:talabatee/features/splash/presentation/widgets/splash_body.dart';
import 'package:talabatee/res/assets_res.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// State class for SplashScreen.
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigationToMain();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splashBody(),
      backgroundColor: HexColor("#e93946"),
    );
  }

  // Navigate to the main screen after 2 seconds
  navigationToMain() => Future.delayed(const Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, HomeScreen.route));
}
