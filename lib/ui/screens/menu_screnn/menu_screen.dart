import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';
import '../../widgets/header_widget/header_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Column(
      children: mediaQuery < 370
          ? [
              const MenuBody(),
            ]
          : [
              const HederWidget(),
              const MenuBody(),
            ],
    );
  }
}

class MenuBody extends StatelessWidget {
  const MenuBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 345.0,
        ),
        itemBuilder: (context, index) => _CartItem(index: index),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return (mediaQuery < 370)
        ? CartItemContainer(index: index)
        : Stack(
            children: [
              CartItemContainer(index: index),
              CartItemImg(index: index),
            ],
          );
  }
}

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    const List<String> im = [
      'assets/imgs/food1.png',
      'assets/imgs/food5.png',
      'assets/imgs/food3.png',
    ];
    return Container(
      decoration: BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(ThemeApp.kRadius),
        ),
        image: MediaQuery.of(context).size.width < 370
            ? DecorationImage(
                image: AssetImage(im[index]),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter)
            : null,
      ),
      margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: const [
            CartItemButtonFavorit(),
            CartItemText(),
          ],
        ),
      ),
    );
  }
}

class CartItemButtonFavorit extends StatelessWidget {
  const CartItemButtonFavorit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: const Icon(
            Icons.favorite_border_sharp,
            color: Colors.grey,
          ),
          onTap: () {},
        )
      ],
    );
  }
}

class CartItemText extends StatelessWidget {
  const CartItemText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(
                color: ThemeApp.kWhite,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 2,
              ),
            ),
          ),
          Divider(color: Colors.grey, thickness: .3),
          Text(
            '\$999',
            style: TextStyle(
              color: ThemeApp.kWhite,
              fontSize: 18,
              fontWeight: FontWeight.normal,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemImg extends StatelessWidget {
  const CartItemImg({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    const List<String> im = [
      'assets/imgs/food1.png',
      'assets/imgs/food5.png',
      'assets/imgs/food3.png',
    ];
    return Positioned(
      child: Image.asset(
        im[index],
        fit: BoxFit.cover,
        width: 110,
      ),
    );
  }
}
//  AnimatedCrossFade(
//               duration: const Duration(milliseconds: 500),
//               firstChild: const _Filter(),
//               secondChild: const SizedBox.shrink(),
//               //2
//               crossFadeState: togFilter
//                   ? CrossFadeState.showSecond
//                   : CrossFadeState.showFirst,
//             ),
