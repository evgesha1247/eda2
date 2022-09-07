import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';
import '../../widgets/home_header_widget/home_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) => MediaQuery.of(context).size.width > 300
      ? Column(children: const [
          HomeHederWidget(),
          HomeBodyWidget(),
        ])
      : const HomeBodyWidget();
}

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          itemCount: 3,
          padding: const EdgeInsets.symmetric(horizontal: ThemeApp.kIndent),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300.0,
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
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(ThemeApp.kIndent),
          decoration: const BoxDecoration(
            color: ThemeApp.kFrontColor,
            borderRadius: BorderRadius.all(Radius.circular(ThemeApp.kIndent)),
          ),
        ),
        const Positioned(
          top: 1,
          child: CircleAvatar(
            backgroundColor: Colors.teal,
            radius: 33,
          ),
        ),
      ],
    );
  }
}
