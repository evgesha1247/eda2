import 'package:flutter/material.dart';
import 'package:text/ui/screens_factory.dart/widget_factory.dart';
import '../../theme/theme_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    final factor = ScreensFactory();
    return mediaQuery < 310
        ? const _BodyWidget()
        : Column(children: [factor.makeHeder(), const _BodyWidget()]);
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _PromoDishesWidget(),
      ],
    );
  }
}

class _PromoDishesWidget extends StatelessWidget {
  const _PromoDishesWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: ThemeApp.kInterval),
        _PromoTextWidget(),
        SizedBox(height: ThemeApp.kInterval),
        _ContentPromoWidget()
      ],
    );
  }
}

class _PromoTextWidget extends StatelessWidget {
  const _PromoTextWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('Hot Promo', style: style(fS: 20, fW: FontWeight.bold));
  }
}

class _ContentPromoWidget extends StatelessWidget {
  const _ContentPromoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: const [
        _ContainerPromoWidget(),
        CircleAvatar(backgroundColor: Colors.orange, radius: 60),
      ],
    );
  }
}

class _ContainerPromoWidget extends StatelessWidget {
  const _ContainerPromoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(minHeight: 100, minWidth: double.infinity),
      child: Container(
        padding: const EdgeInsets.only(left: 130),
        decoration: const BoxDecoration(
          color: ThemeApp.kFrontColor,
          borderRadius: BorderRadius.all(
            Radius.circular(ThemeApp.kRadius),
          ),
        ),
        child: const _ContainerPromoTextWidget(),
      ),
    );
  }
}

class _ContainerPromoTextWidget extends StatelessWidget {
  const _ContainerPromoTextWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('seafood noodles', style: style(fS: 18)),
        Text('Lorem ipsum dolor sit amet, consectetur adipiscing ',
            style: style(fS: 14, fW: FontWeight.w400)),
        Text('\$ 9.99', style: style(fS: 20, fW: FontWeight.w400)),
      ],
    );
  }
}

style({double fS = 18, FontWeight fW = FontWeight.normal}) {
  return TextStyle(
      color: ThemeApp.kWhite, fontSize: fS, fontWeight: fW, letterSpacing: 2);
}
