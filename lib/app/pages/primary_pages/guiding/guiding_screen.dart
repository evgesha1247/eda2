import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_controller.dart';
import '../../../widgets/text/my_text.dart';
import '../favorite/favorite_page.dart';
import '../home/home_page.dart';
import '../menu/menu_page.dart';
import '../profile/profile_page.dart';

class _MenuItem {
  final String text;
  final IconData icon;
  const _MenuItem({
    required this.text,
    required this.icon,
  });
}

const List<_MenuItem> _menuData = [
  _MenuItem(text: 'Home', icon: Icons.home),
  _MenuItem(text: 'Menu', icon: Icons.restaurant_menu),
  _MenuItem(text: 'favorite', icon: Icons.favorite),
  _MenuItem(text: 'User', icon: Icons.person),
  _MenuItem(text: '', icon: Icons.menu_outlined),
];


class GuidingPage extends StatelessWidget {
  const GuidingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = context.width;
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
        children: const [
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
        items: List.generate(
          _menuData.length - 1,
          (index) => BottomNavigationBarItem(
            label: _menuData[index].text,
            icon: Icon(_menuData[index].icon),
          ),
        ),
      ),
    );
  }
}

class _FlotingButtom extends StatefulWidget {
  const _FlotingButtom({Key? key}) : super(key: key);
  @override
  State<_FlotingButtom> createState() => _FlotingButtomState();
}

class _FlotingButtomState extends State<_FlotingButtom>
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
  _BuildFlotingButtom();
  final controller = Get.find<GuidingController>();
  @override
  Widget build(BuildContext context) {
    const double buttonDiameter = 60;
    return Flow(
      delegate: FlowMenuDelegate(
        animatedContainer: controller.animatedContainer,
      ),
      children: List.generate(
        _menuData.length,
        (index) => RawMaterialButton(
          fillColor: Get.context?.theme.primaryColor,
          splashColor: Get.context?.theme.cardColor,
          elevation: 8,
          shape: const CircleBorder(),
          constraints:
              BoxConstraints.tight(const Size(buttonDiameter, buttonDiameter)),
          onPressed: () => controller.updatePage(_menuData[index].icon, index),
          child: GetBuilder<GuidingController>(
            builder: (_) {
              return Icon(
                _menuData[index].icon,
                color: controller.selectIcon == _menuData[index].icon
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
