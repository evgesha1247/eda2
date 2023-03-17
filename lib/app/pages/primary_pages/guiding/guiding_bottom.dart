import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/guiding_controller.dart';
import 'model/guiding_menu_model.dart';

/// menu
class BottomGuiding extends StatelessWidget {
  const BottomGuiding({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuidingController>(
      builder: (constroller) => BottomNavigationBar(
        onTap: constroller.setCurrentIndexTab,
        currentIndex: constroller.currentIndexTab,
        selectedItemColor: context.theme.hintColor,
        unselectedItemColor: context.theme.hintColor.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        elevation: 5,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: List.generate(
          DataMenuGuiding().listPage.length - 1,
          (index) => BottomNavigationBarItem(
            label:
                DataMenuGuiding()
                .listPage[index]
                .text, //MenuData.listPage[index].text,
            icon: Icon(DataMenuGuiding().listPage[index].icon),
          ),
        ),
      ),
    );
  }
}

/// elivation botton

class FlotingGuiding extends StatefulWidget {
  const FlotingGuiding({Key? key}) : super(key: key);
  @override
  State<FlotingGuiding> createState() => _FlotingGuidingState();
}

class _FlotingGuidingState extends State<FlotingGuiding>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<GuidingController>();
  @override
  initState() {
    super.initState();
    controller.animatedContainer = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _BuildFlotingButtom();
  }
}

class _BuildFlotingButtom extends StatelessWidget {
  final controller = Get.find<GuidingController>();
  @override
  Widget build(BuildContext context) {
    const double buttonDiameter = 60;
    return Flow(
      delegate: FlowMenuDelegate(
        animatedContainer: controller.animatedContainer,
      ),
      children: List.generate(
        DataMenuGuiding().listPage.length,
        (index) => RawMaterialButton(
          fillColor: Get.context?.theme.primaryColor,
          splashColor: Get.context?.theme.cardColor,
          elevation: 8,
          shape: const CircleBorder(),
          constraints:
              BoxConstraints.tight(const Size(buttonDiameter, buttonDiameter)),
          onPressed: () =>
              controller.updatePage(DataMenuGuiding().listPage[index].icon, index),
          child: GetBuilder<GuidingController>(
            builder: (_) {
              return Icon(
                DataMenuGuiding().listPage[index].icon,
                color: controller.selectIcon == DataMenuGuiding().listPage[index].icon
                    ? Colors.white
                    : Colors.grey[800],
              );
            },
          ),
        ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> animatedContainer;
  final buttonSize = 65.0;
  FlowMenuDelegate({required this.animatedContainer})
      : super(repaint: animatedContainer);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;
    final n = context.childCount;
    for (var i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      setValue(value) => isLastItem ? 0.0 : value;
      final theta = i * (pi * 0.5 / (n - 2));
      final radius = 120 * animatedContainer.value;
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(buttonSize / 2, buttonSize / 2)
          ..rotateZ(
              isLastItem ? 0.0 : 180 * (1 - animatedContainer.value) * pi / 180)
          ..scale(
            isLastItem ? 1.0 : min(0.8, animatedContainer.value),
          )
          ..translate(-buttonSize / 2, -buttonSize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
