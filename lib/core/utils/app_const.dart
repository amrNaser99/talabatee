import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:logger/logger.dart';

final logger = Logger();
String? userToken;
String? username;
String? companyKey;
String? drawerWidget;
int userAttendanceType = 0;
String trackingType = "1";

class AppConst {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static const shadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 10.0,
      spreadRadius: .5,
      offset: Offset(0.0, 2.0),
    ),
  ];
  final logger = Logger();

  static const borderRadius = 16.0;
  static const minBorderRadius = 10.0;
  static const mainPadding = 20.0;
  static const midPadding = 16.0;
  static const smallPadding = 8.0;
  static const elevation = 5.0;
  static final removeEmoji = FilteringTextInputFormatter.deny(
    RegExp(
        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
  );

  // static const ROOM_TABLE_TRANSACTIONS = "transactions_table";
  // static const talabatee_DATABASE_NAME = "talabatee_DATABASE";

  static InputDecoration tFFInputDecoration(
      {String? hintText,
      EdgeInsetsGeometry? contentPadding,
      TextStyle? hintStyle,
      Widget? suffix,
      TextEditingController? controller}) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.greyColor.withOpacity(0.5),
      filled: true,
      hintText: hintText,
      hintStyle: hintStyle,
      suffixIcon: controller != null
          ? controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                )
              : null
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: AppConst.midPadding),
    );
  }

  static final tFFAreaDecoration = InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: AppColors.greyColor.withOpacity(0.5),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
      borderSide: BorderSide(color: AppColors.greyColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
      borderSide: const BorderSide(color: Colors.blueAccent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
      borderSide: BorderSide(color: AppColors.greyColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.minBorderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: AppConst.midPadding),
  );

  static String handleLargeNumbers(String text, {bool? isMeter}) {
    double num = double.parse(text);
    String result = num.toString();
    if (num >= 1000) {
      if (isMeter == true) {
        result = "${(num / 1000).round()}K";
      } else {
        result = "${(num / 1000)}K";
      }
    } else
      result = num.round().toString();
    return result;
  }
}

final KTextFieldCustomerDecoration = InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.grey.shade100.withOpacity(0.5),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.borderRadius),
      borderSide: BorderSide(color: Colors.grey.shade200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.borderRadius),
      borderSide: const BorderSide(color: Colors.blueAccent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.borderRadius),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConst.borderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    labelStyle: const TextStyle(
      color: Colors.black,
    ));
