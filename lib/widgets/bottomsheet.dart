import 'package:flutter/material.dart';


void openBottomSheet({
  required BuildContext context,
  AnimationController? animationController,
  required WidgetBuilder builder,
}) =>
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        // constraints:
        //     BoxConstraints.tightFor(height: SizeConfig.screenHeight! * 0.5),
        useSafeArea: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: builder,
      );
    });
