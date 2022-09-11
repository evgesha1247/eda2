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
              const SizedBox(height: ThemeApp.kInterval),
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
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemBuilder: (context, i) => _CartItem(index: i)),
    );
  }
}

class _CartItem extends StatelessWidget {
  _CartItem({Key? key, required this.index}) : super(key: key);
  final int index;
  List im = [
    'assets/imgs/food.png',
    'assets/imgs/food2.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: ThemeApp.kFrontColor,
            borderRadius: BorderRadius.all(Radius.circular(ThemeApp.kRadius)),
          ),
        ),
        Positioned(
          top: -10,
          left: -10,
          child: index % 3 == 0
              ? Image.asset(
                  im[0],
                  width: 120,
                )
              : Image.asset(
                  im[1],
                  width: 120,
                ),
        ),
      ],
    );
  }
}
