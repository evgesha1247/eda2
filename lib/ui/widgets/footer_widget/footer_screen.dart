import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/screens_factory.dart/widget_factory.dart';
import 'footer_screen_model.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _FooterBodyWidget(),
      floatingActionButton: _FooterFlotingButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: _FooterBottomBarWidget(),
      backgroundColor: Color.fromARGB(255, 32, 35, 51),
    );
  }
}

class _FooterBodyWidget extends StatelessWidget {
  const _FooterBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab =
        context.select((FooterScreenModel e) => e.currentIndexTab);
    final _homeScreen = ScreensFactory();
    return IndexedStack(
      index: currentIndexTab,
      children: [
        _homeScreen.makeHomeScreen(), // HomeScreen(),
        Text('4'),
        Text('4'),
        Text('4'),
      ],
    );
  }
}

class _FooterBottomBarWidget extends StatelessWidget {
  const _FooterBottomBarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab =
        context.select((FooterScreenModel e) => e.currentIndexTab);
    final model = context.read<FooterScreenModel>();
    return BubbleBottomBar(
      items: <BubbleBottomBarItem>[
        bubbItem('Home', 0xffFF6C0C, Icons.home),
        bubbItem('Menu', 0xffF7C701, Icons.restaurant_menu_rounded),
        bubbItem('Favorite', 0xffFF3D00, Icons.favorite),
        bubbItem('Profile', 0xffF7C701, Icons.settings),
      ],
      backgroundColor: const Color.fromARGB(255, 46, 43, 64),
      opacity: .2,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 0,
      fabLocation: BubbleBottomBarFabLocation.end, //new
      currentIndex: currentIndexTab,
      onTap: model.setCurrentIndexTab,
    );
  }
}

class _FooterFlotingButtom extends StatelessWidget {
  const _FooterFlotingButtom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 35,
      backgroundColor: Color.fromARGB(255, 46, 43, 64),
      child: Center(
        child: FloatingActionButton(
          elevation: 0,
          onPressed: null,
          backgroundColor: Color(0xffF7C701),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

bubbItem(String text, int textColor, IconData icon) {
  return BubbleBottomBarItem(
// showBadge: true , badge: Text("5"), badgeColor: ...
    backgroundColor: Color(textColor),
    icon: Icon(icon, color: Color(textColor).withAlpha(112)),
    activeIcon: const SizedBox(),
    title: Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Text(text),
    ),
  );
}
