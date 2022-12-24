// ignore_for_file: deprecated_member_use


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import '../favorite/favorite_page.dart';
import '../home/home_page.dart';
import '../menu/menu_page.dart';
import '../profile/profile_page.dart';

class GuidingPage extends StatelessWidget {
  const GuidingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: const _GuidingBody(),
      bottomNavigationBar: (width >= 370) ? const _BottomBarWidget() : null,
      floatingActionButton: (width < 370) ? const _FlotingButtom() : null,
    );
  }
}

class _GuidingBody extends StatelessWidget {
  const _GuidingBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuidingController>(
      builder: (controller) => IndexedStack(
        index: controller.currentIndexTab,
        children: [
          HomePage(),
          MenuPage(),
          FavoritePage(),
          ProfilePage(),
        ],
      ),
    );

  }
}

class _BottomBarWidget extends StatelessWidget {
  const _BottomBarWidget({Key? key}) : super(key: key);
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
        items: [
          bottomItem('Home', Icons.home),
          bottomItem('Menu', Icons.restaurant_menu),
          bottomItem('favorite', Icons.favorite),
          bottomItem('History', Icons.history),
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomItem(String text, IconData icon) {
  return BottomNavigationBarItem(
    label: text,
    icon: Icon(icon),
  );
}




const buttonSize = 65.0;

class _FlotingButtom extends StatefulWidget {
  const _FlotingButtom({Key? key}) : super(key: key);
  @override
  State<_FlotingButtom> createState() => _FlotingButtomState();
}

class _FlotingButtomState extends State<_FlotingButtom>
    with SingleTickerProviderStateMixin {
  late AnimationController animatedContainer;

  @override
  initState() {
    super.initState();
    animatedContainer = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    animatedContainer.dispose();
    super.dispose();
  }

  IconData selectIcon = Icons.menu_outlined;
  void _updatePage(int index) {
    if (iconFlotIconData[index] != Icons.menu_outlined) {}
    controller.setCurrentIndexTab(index);
    selectIcon = iconFlotIconData[index];
    setState(() {});
  }

  final List iconFlotIconData = const [
    Icons.home,
    Icons.restaurant_menu,
    Icons.favorite,
    Icons.history,
    Icons.menu_outlined,
  ];

  final controller = Get.find<GuidingController>();
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(animatedContainer: animatedContainer),
      children: List.generate(
              iconFlotIconData.length, (index) => buildFlotingIcons(index))
          .toList(),
    );
  }

  Widget buildFlotingIcons(int index) {
    const double buttonDiameter = 60;
    return RawMaterialButton(
      fillColor: context.theme.primaryColor,
      splashColor: context.theme.cardColor,
      elevation: 8,
      shape: const CircleBorder(),
      constraints:
          BoxConstraints.tight(const Size(buttonDiameter, buttonDiameter)),
      onPressed: () {
        index == iconFlotIconData.length - 1
            ? animatedContainer.status == AnimationStatus.completed
                ? animatedContainer.reverse()
                : animatedContainer.forward()
            : _updatePage(index);
      },
      child: Icon(
        iconFlotIconData[index],
        color: selectIcon == iconFlotIconData[index]
            ? Colors.white
            : Colors.grey[800],
      ),
    );

    // GestureDetector(
    //   onTap: () {
    //     index == iconFlotIconData.length - 1
    // ? animatedContainer.status == AnimationStatus.completed
    //     ? animatedContainer.reverse()
    //     : animatedContainer.forward()
    //         : controller.setCurrentIndexTab(index);
    //   },
    //   child: ClipOval(
    //     child: Container(
    //       width: buttonSize,
    //       height: buttonSize,
    //       color: Colors.teal,
    //       child: ClipOval(
    //         child: Icon(icon),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> animatedContainer;
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
