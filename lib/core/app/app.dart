
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabatee/core/utils/app_const.dart';
import 'package:talabatee/core/utils/app_themes.dart';
import 'package:talabatee/core/utils/routes.dart';
import 'package:talabatee/core/utils/size_config.dart';
import 'package:talabatee/res/assets_res.dart';

class TalabateeApp extends StatefulWidget {
  const TalabateeApp({super.key});

  @override
  State<TalabateeApp> createState() => _TalabateeAppState();
}

class _TalabateeAppState extends State<TalabateeApp> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScreenUtilInit(
      designSize: SizeConfig.screenSize!,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return LayoutBuilder(
          builder: (context, boxSizing) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: AppConst.scaffoldMessengerKey,
              title: AssetsRes.APP_NAME,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: AppThemes.lightTheme,
              routes: routes,
            );
          },
        );
      },
    );
  }
}
