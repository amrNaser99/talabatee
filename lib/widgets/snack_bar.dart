import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_const.dart';
import 'package:talabatee/core/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarGlobal {
  static void show(
      {required String message, Color? color, Duration? duration}) {
    if (AppConst.scaffoldMessengerKey.currentState != null) {
      log("in SnackBarGlobal");
      AppConst.scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            backgroundColor: color ?? AppColors.primaryColor,
            duration: duration ?? const Duration(seconds: 3),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            content: Text(
              message,
              style: AppThemes.lightTheme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        );
    }
  }
}

class ToastGlobal {
  static void show({required String message}) {
    Fluttertoast.showToast(
      msg: message.tr(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
// showSnackBar(String message, BuildContext context, {Color? color}) {
//   ScaffoldMessenger.of(context).clearSnackBars();
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: color ?? Theme.of(context).colorScheme.secondary,
//       duration: const Duration(seconds: 1),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(12),
//         ),
//       ),
//       content: Text(message.tr(),
//           style: AppThemes.lightTheme.textTheme.bodyLarge
//               ?.copyWith(color: Colors.white)),
//     ),
//   );
// }
