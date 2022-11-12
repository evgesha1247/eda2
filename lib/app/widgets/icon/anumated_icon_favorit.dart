import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedIconWidget extends StatelessWidget {
  final Widget widget1;
  final Widget widget2;
  final Function? fun;
  final RxInt currIndex;
  const AnimatedIconWidget({
    super.key,
    this.widget1 = const Icon(Icons.favorite),
    this.widget2 = const Icon(Icons.favorite_outline),
    this.fun,
    required this.currIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fun != null ? fun!() : null,
      child: Obx(() => AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('1')
                    ? Tween<double>(begin: 1, end: 0).animate(anim)
                    : Tween<double>(begin: 0, end: 1).animate(anim),
                child: ScaleTransition(scale: anim, child: child),
              ),
          child: currIndex.value == 0
              ? SizedBox(key: const ValueKey('1'), child: widget1)
              : SizedBox(key: const ValueKey('2'), child: widget2))),
    );
  }
}
