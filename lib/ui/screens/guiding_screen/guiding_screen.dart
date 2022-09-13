import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import '../../screens_factory.dart/widget_factory.dart';
import 'guiding_model.dart';

class GuidingScreen extends StatelessWidget {
  const GuidingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      body: const _GuidingBodyWidget(),
      floatingActionButton:
          (mediaQuery < 370) ? const _FooterFlotingButtom() : null,
      bottomNavigationBar:
          (mediaQuery >= 370) ? const _FooterBottomBarWidget() : null,
      backgroundColor: ThemeApp.kBGColor,
    );
  }
}

class _GuidingBodyWidget extends StatelessWidget {
  const _GuidingBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab = context.select((GuidingScreenModel e) {
      return e.currentIndexTab;
    });
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeApp.kInterval),
        child: IndexedStack(
          index: currentIndexTab,
          children: [
            ScreensFactory().makeHome(),
            ScreensFactory().makeMenu(),
            ScreensFactory().makeFavorit(),
            const Text(''),
          ],
        ),
      ),
    );
  }
}

class _FooterBottomBarWidget extends StatelessWidget {
  const _FooterBottomBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab =
        context.select((GuidingScreenModel e) => e.currentIndexTab);
    final model = context.read<GuidingScreenModel>();
    return BottomNavBar(
      curve: Curves.ease,
      showElevation: true,
      itemCornerRadius: ThemeApp.kRadius,
      selectedIndex: currentIndexTab,
      containerHeight: 53,
      containerPadding: EdgeInsets.zero,
      backgroundColor: ThemeApp.kBGColor,
      onItemSelected: model.setCurrentIndexTab,
      animationDuration: const Duration(milliseconds: 300),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      items: <BottomNavBarItem>[
        bubbItem('Home', Icons.home, currentIndexTab),
        bubbItem('Menu', Icons.restaurant_menu_rounded, currentIndexTab),
        bubbItem('Favorite', Icons.favorite, currentIndexTab),
        bubbItem('Profile', Icons.settings, currentIndexTab),
      ],
    );
  }
}

class _FooterFlotingButtom extends StatelessWidget {
  const _FooterFlotingButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 33,
      backgroundColor: ThemeApp.kFrontColor,
      child: Center(
        child: FloatingActionButton(
          elevation: 0,
          onPressed: null,
          backgroundColor: ThemeApp.kAccent,
          child: Icon(Icons.menu_sharp),
        ),
      ),
    );
  }
}

bubbItem(String text, IconData icon, int index) {
  final listIntActiveColor = [0xffF7C701, 0xffff9a76, 0xfff52e63, 0xffd49a89];
  return BottomNavBarItem(
    title: text,
    icon: Icon(icon),
    inactiveColor: ThemeApp.kFrontColor,
    activeColor: Color(listIntActiveColor[index]),
    activeBackgroundColor: ThemeApp.kFrontColor,
  );
}
