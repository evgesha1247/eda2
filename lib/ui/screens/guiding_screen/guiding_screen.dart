import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
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
          (mediaQuery < 310) ? const _FooterFlotingButtom() : null,
      bottomNavigationBar:
          (mediaQuery >= 310) ? const _FooterBottomBarWidget() : null,
      backgroundColor: ThemeApp.kBGColor,
    );
  }
}

class _GuidingBodyWidget extends StatelessWidget {
  const _GuidingBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final currentIndexTab =
        context.select((GuidingScreenModel e) => e.currentIndexTab);
    return IndexedStack(
      index: currentIndexTab,
      children: [
        ScreensFactory().makeMenuHome(),
        const Text('data'),
        const Text('data'),
        const Text('data'),
      ],
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
    return BubbleBottomBar(
      items: <BubbleBottomBarItem>[
        bubbItem('Home', 0xffFF6C0C, Icons.home),
        bubbItem('Menu', 0xffF7C701, Icons.restaurant_menu_rounded),
        bubbItem('Favorite', 0xffFF3D00, Icons.favorite),
        bubbItem('Profile', 0xffF7C701, Icons.settings),
      ],
      backgroundColor: ThemeApp.kFrontColor,
      opacity: .2,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 0,
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

bubbItem(String text, int textColor, IconData icon) {
  return BubbleBottomBarItem(
// showBadge: true , badge: Text("5"), badgeColor: ...
    backgroundColor: Color(textColor),
    icon: Icon(icon, color: Color(textColor).withAlpha(112)),
    activeIcon: const SizedBox(),
    title: Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(text),
    ),
  );
}
