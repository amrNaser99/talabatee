import 'package:talabatee/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:talabatee/core/utils/app_const.dart';
import 'package:talabatee/core/utils/size_config.dart';

class MainCard extends StatelessWidget {
  final Widget child;

  const MainCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.all(
          Radius.circular(AppConst.borderRadius),
        ),
      ),
      elevation: AppConst.elevation,
      child: Container(
        width: SizeConfig.screenWidth! * 0.9,
        padding: const EdgeInsetsDirectional.all(
          AppConst.mainPadding,
        ),
        color: AppColors.whiteColor,
        child: child,
      ),
    );
  }
}
