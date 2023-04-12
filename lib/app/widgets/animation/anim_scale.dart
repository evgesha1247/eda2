import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AnimationScaleWidget extends StatelessWidget {
  final Widget widget;
  final RxBool select;
  final int durationMilliseconds;
  const AnimationScaleWidget({
    super.key,
    required this.widget,
    required this.select,
    this.durationMilliseconds = 750,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedScale(
          curve: Curves.easeOutCirc,
          duration: Duration(milliseconds: durationMilliseconds),
          scale: select.value ? 1 : 0,
          child: widget,
        ));
  }
}
