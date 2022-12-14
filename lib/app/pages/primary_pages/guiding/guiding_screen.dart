// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_controller.dart';
import '../cart_history/cart_history.dart';
import '../favorite/favorite_page.dart';
import '../home/home_page.dart';
import '../menu/menu_page.dart';

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
      builder: (model) => IndexedStack(
        index: model.currentIndexTab,
        children: const [
          HomePage(),
          MenuPage(),
          FavoritePage(),
          CartHistory(),
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
      builder: (model) => BottomNavigationBar(
        onTap: model.setCurrentIndexTab,
        currentIndex: model.currentIndexTab,
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

class _FlotingButtom extends StatelessWidget {
  const _FlotingButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: null,
      backgroundColor: ThemeMode.system == ThemeMode.dark
          ? context.theme.accentColor
          : context.theme.primaryColor,
      child: const Icon(Icons.menu_sharp),
    );
  }
}
