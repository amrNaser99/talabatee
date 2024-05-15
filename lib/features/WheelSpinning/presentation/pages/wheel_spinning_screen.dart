import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:ionicons/ionicons.dart';
import 'package:talabatee/core/utils/app_color.dart';
import 'package:talabatee/core/utils/app_const.dart';
import 'package:talabatee/core/utils/app_spaces.dart';
import 'package:talabatee/widgets/succcess_dialog.dart';

class WheelSpinningScreen extends StatefulWidget {
  const WheelSpinningScreen({super.key});

  @override
  WheelSpinningScreenState createState() => WheelSpinningScreenState();
}

class WheelSpinningScreenState extends State<WheelSpinningScreen> {
  StreamController<int> selected = StreamController<int>();
  bool isSpin = false; // Initial value to indicate no selection
  final giftList = [
    "حظا اوفر المرة القادمة",
    "شحن 5 ريال للمحفظة",
    "10 ريال كاش باك للطلبات فوق 50 ريال",
    "توصيل مجاني للطلبات فوق 50 ريال",
    "20 % كاش باك",
  ];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: FortuneWheel(
              styleStrategy: FortuneWheel.kDefaultStyleStrategy,
              physics: CircularPanPhysics(
                duration: const Duration(seconds: 1),
                curve: Curves.decelerate,
              ),
              onAnimationEnd: () {
                  isSpin = false;

              },
              onFling: () {
                Fortune.randomInt(0, giftList.length);

              },
              onAnimationStart: () {

                  isSpin = true;

              },
              selected: selected.stream,
              animateFirst: false,
              onFocusItemChanged: (value) {
                // log("value ${value}");
                log("lastIndex ${value}");

                // showSuccessDialog(
                //     context, "لقد حصلت علي ${giftList[value]}");
              },
              items: [
                FortuneItem(
                  child: const Text(
                    'حظا اوفر المرة القادمة',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: FortuneItemStyle(
                    color: HexColor("#FCBEBE"),
                  ),
                ),
                FortuneItem(
                  child: const Text(
                    'شحن 5 ريال للمحفظة',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  style: FortuneItemStyle(
                    color: HexColor("#E1BEFC"),
                  ),
                ),
                FortuneItem(
                  child: Text(
                    '10 ريال كاش باك للطلبات \nفوق 50 ريال',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.s12),
                  ),
                  style: FortuneItemStyle(
                    color: HexColor("#BFFFF1"),
                  ),
                ),
                FortuneItem(
                  child: const Text(
                    'توصيل مجاني للطلبات\n فوق 50 ريال',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: FortuneItemStyle(
                    color: HexColor("#FFEF85"),
                  ),
                ),
                FortuneItem(
                  child: const Text(
                    '20 % كاش باك',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: FortuneItemStyle(
                    color: HexColor("#3CAA3666"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Icon(Ionicons.arrow_redo_circle),
                Text(
                  "جرب حظك مع طلباتي",
                  style: TextStyle(fontSize: AppSize.s16),
                ),
                Text(
                  "جرب حظك و اربح هدية مختلفة كل يوم",
                  style: TextStyle(fontSize: AppSize.s16),
                ),
                TextButton(
                  onPressed: () {
                    selected.add(Fortune.randomInt(0, giftList.length));
                  },
                  child: const Text('دور العجلة'),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
