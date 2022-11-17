import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/page/menu/menu_screen.dart';
import 'package:text/app/page/profile/profile_screen.dart';
import 'package:text/app/theme/theme_app.dart';
import '../favorite/favorite_screen.dart';
import '../home/home_page.dart';
import 'guiding_model.dart';

class GuidingScreen extends StatelessWidget {
  const GuidingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: const _GuidingBodyWidget(),
      bottomNavigationBar: (width >= 370) ? const _BottomBarWidget() : null,
      floatingActionButton: (width < 370) ? const _FlotingButtom() : null,
    );
  }
}

class _GuidingBodyWidget extends StatelessWidget {
  const _GuidingBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuidingScreenModel>(
      builder: (model) => IndexedStack(
        index: model.currentIndexTab,
        children: const [
          HomeScreen(),
          MenuScreen(),
          FavoriteScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}

class _BottomBarWidget extends StatelessWidget {
  const _BottomBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GuidingScreenModel>(
      builder: (model) => BottomNavigationBar(
        onTap: model.setCurrentIndexTab,
        currentIndex: model.currentIndexTab,
        selectedItemColor: ThemeAppColor.kAccent,
        unselectedItemColor: ThemeAppColor.kAccent2,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ThemeAppColor.kBGColor,
        elevation: 5,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: [
          bottomItem('Home', Icons.home),
          bottomItem('Menu', Icons.restaurant_menu_rounded),
          bottomItem('favorite', Icons.favorite),
          bottomItem('Profile', Icons.settings),
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
    return const FloatingActionButton(
      elevation: 0,
      onPressed: null,
      backgroundColor: ThemeAppColor.kAccent,
      child: Icon(Icons.menu_sharp),
    );
  }
}
