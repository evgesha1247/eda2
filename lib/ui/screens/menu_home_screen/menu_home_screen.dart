import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';
import '../../widgets/home_header_widget/home_header_widget.dart';

class MenuHomeScreen extends StatelessWidget {
  const MenuHomeScreen({super.key});
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context).size.width;

    return Column(
      children: mediaQuery < 310
          ? [
              const HomeBodyWidget(),
            ]
          : [
              const HomeHederWidget(),
              const HomeBodyWidget(),
            ],
    );
  }
}

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: 5,
          padding: const EdgeInsets.symmetric(horizontal: ThemeApp.kIndent),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 310.0,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, i) => const _CartItem()),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ThemeApp.kIndent),
      decoration: const BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: BorderRadius.all(Radius.circular(ThemeApp.kIndent)),
      ),
    );
  }
}
