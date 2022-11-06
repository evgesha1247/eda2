import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/factory/widget_factory.dart';
import 'package:text/app/theme/theme_app.dart';
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

class _GuidingBodyWidget extends GetView<GuidingScreenModel> {
  const _GuidingBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (GuidingScreenModel model) => IndexedStack(
        index: model.currentIndexTab,
        children: [
          ScreensFactory.instance.makeHome(),
          ScreensFactory.instance.makeMenu(),
          ScreensFactory.instance.makeFavorite(),
          ScreensFactory.instance.makeProfile()
        ],
      ),
    );
  }
}

class _FooterBottomBarWidget extends GetView<GuidingScreenModel> {
  const _FooterBottomBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (GuidingScreenModel model) => BottomNavBar(
              curve: Curves.easeInOutCubicEmphasized,
              showElevation: false,
              itemCornerRadius: ThemeAppSize.kRadius20,
              selectedIndex: model.currentIndexTab,
              containerHeight: 60,
              containerPadding: EdgeInsets.only(top: ThemeAppSize.kInterval5),
              backgroundColor: ThemeAppColor.kBGColor,
              onItemSelected: model.setCurrentIndexTab,
              animationDuration: const Duration(milliseconds: 300),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              items: <BottomNavBarItem>[
                bottomItem('Home', Icons.home, model.currentIndexTab),
                bottomItem('Menu', Icons.restaurant_menu_rounded,
                    model.currentIndexTab),
                bottomItem('favorite', Icons.favorite, model.currentIndexTab),
                bottomItem('Profile', Icons.settings, model.currentIndexTab),
              ],
      ),
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
