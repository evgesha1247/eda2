import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/favorite_screen/favorite_screen.dart';
import 'package:text/ui/screens/home_screen/home_screen.dart';
import 'package:text/ui/screens/menu_screnn/menu_screen.dart';
import 'package:text/ui/theme/theme_app.dart';
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
      child: IndexedStack(
        index: currentIndexTab,
        children: const [
          HomeScreen(),
          MenuScreen(),
          FavoriteScreen(),
          Text(''),
        ],
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
      curve: Curves.easeInOutCubicEmphasized,
      showElevation: false,
      itemCornerRadius: ThemeAppSize.kRadius,
      selectedIndex: currentIndexTab,
      containerHeight: 60,
      containerPadding: const EdgeInsets.only(top: 8),
      backgroundColor: ThemeAppColor.kBGColor,
      onItemSelected: model.setCurrentIndexTab,
      animationDuration: const Duration(milliseconds: 300),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      items: <BottomNavBarItem>[
        bottomItem('Home', Icons.home, currentIndexTab),
        bottomItem('Menu', Icons.restaurant_menu_rounded, currentIndexTab),
        bottomItem('favorite', Icons.favorite, currentIndexTab),
        bottomItem('Profile', Icons.settings, currentIndexTab),
      ],
    );
  }
}

bottomItem(String text, IconData icon, int index) {
  return BottomNavBarItem(
    title: text,
    icon: Icon(icon),
    inactiveColor: ThemeAppColor.kFrontColor,
    activeColor: ThemeAppColor.kBGColor,
    activeBackgroundColor: ThemeAppColor.kFrontColor,
  );
}

class _FooterFlotingButtom extends StatelessWidget {
  const _FooterFlotingButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 33,
      backgroundColor: ThemeAppColor.kFrontColor,
      child: Center(
        child: FloatingActionButton(
          elevation: 0,
          onPressed: null,
          backgroundColor: ThemeAppColor.kAccent,
          child: Icon(Icons.menu_sharp),
        ),
      ),
    );
  }
}
