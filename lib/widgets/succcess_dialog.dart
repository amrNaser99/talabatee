import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Future showSuccessDialog(context, String? text,
    [VoidCallback? afterDuration]) async {
  final res = showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 25),
              child: Center(
                child: Icon(
                  Ionicons.checkmark,
                  // height: 82,
                  // width: 117,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Center(
                  child: Text(
                text?.tr() ?? "".tr(),
                style: const TextStyle(fontSize: 18),
              )),
            ),
          ],
        );
      });

  res.whenComplete(() => afterDuration != null ? afterDuration() : null);
  res.timeout(const Duration(milliseconds: 2000),
      onTimeout: () => Navigator.pop(context));
}

Future showResetSuccessDialog(context, String? text,
    [VoidCallback? afterDuration]) async {
  final res = showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                    child: Image.asset(
                  "assets/icons/success.gif",
                  height: 82,
                  width: 117,
                ))),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Center(
                  child: Text(
                text?.tr() ?? "Payment completed successfully".tr(),
                style: const TextStyle(fontSize: 18),
              )),
            ),
          ],
        );
      });

  res.whenComplete(() => afterDuration != null ? afterDuration() : null);
  res.timeout(const Duration(milliseconds: 2000),
      onTimeout: () => Navigator.pop(context));
}
