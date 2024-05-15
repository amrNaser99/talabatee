import 'package:flutter/material.dart';
import 'package:talabatee/core/utils/size_config.dart';
import 'package:talabatee/res/assets_res.dart';

Widget splashBody() => Stack(
      alignment: Alignment.center,
      children: [
// Displaying the app logo in the center of the screen.
        Center(
          child: Image.asset(
            AssetsRes.APP_LOGO,
            width: SizeConfig.screenWidth! * 0.6,
          ),
        ),
// Positioned CircularProgressIndicator at the bottom of the screen.
        PositionedDirectional(
          bottom: SizeConfig.screenHeight! * 0.1,
          child: const CircularProgressIndicator(color: Colors.white,),
        ),
      ],
    );
