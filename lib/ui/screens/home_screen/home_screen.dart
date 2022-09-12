import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';
import '../../widgets/header_widget/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return mediaQuery < 310
        ? const _BodyWidget()
        : Column(
            children: const [
              HederWidget(),
              SizedBox(height: ThemeApp.kInterval),
              _BodyWidget(),
            ],
          );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ActualDishes(),
      ],
    );
  }
}

class ActualDishes extends StatelessWidget {
  const ActualDishes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: ThemeApp.kInterval),
        const Text(
          'Hot Promo',
          style: TextStyle(
            color: ThemeApp.kWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: ThemeApp.kInterval),
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                  minHeight: 100, minWidth: double.infinity),
              child: Container(
                padding: const EdgeInsets.only(left: 130),
                decoration: const BoxDecoration(
                  color: ThemeApp.kFrontColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(ThemeApp.kRadius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'seafood noodles',
                      style: TextStyle(
                        color: ThemeApp.kWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing ',
                      style: TextStyle(
                        color: ThemeApp.kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      '\$ 9.99',
                      style: TextStyle(
                        color: ThemeApp.kWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 60,
            ),
          ],
        )
      ],
    );
  }
}
