import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/object/dish_object.dart';
import '../../../object/dish_adding.dart';
import '../../theme/theme_app.dart';
import '../../widgets/header_widget/header_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Column(
      children: mediaQuery < 370
          ? [const MenuBody()]
          : [const HederWidget(), const MenuBody()],
    );
  }
}

class MenuBody extends StatelessWidget {
  const MenuBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishData = Provider.of<DishDataPovider>(context);
    return Expanded(
      child: GridView.builder(
        itemCount: dishData.dishs.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 345.0,
        ),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: dishData.dishs[index],
          child: const _CartItem(),
        ),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return (mediaQuery < 370)
        ? const CartItemContainer()
        : Stack(children: const [CartItemContainer(), CartItemImg()]);
  }
}

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishData = Provider.of<Dish>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: ThemeApp.kFrontColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(ThemeApp.kRadius),
        ),
        image: MediaQuery.of(context).size.width < 370
            ? DecorationImage(
                image: AssetImage(dishData.imgUrl),
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

class CartItemText extends StatelessWidget {
  const CartItemText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishData = Provider.of<Dish>(context, listen: false);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dishData.name,
              style: const TextStyle(
                color: ThemeApp.kWhite,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 2,
              ),
            ),
          ),
          const Divider(color: Colors.grey, thickness: .3),
          Text(
            '\$ ${dishData.price}',
            style: const TextStyle(
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
  const CartItemImg({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishData = Provider.of<Dish>(context, listen: false);
    return Positioned(
      child: Image.asset(
        dishData.imgUrl,
        fit: BoxFit.cover,
        width: 110,
      ),
    );
  }
}

class CartItemButtonFavorit extends StatelessWidget {
  const CartItemButtonFavorit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishData = Provider.of<DishAddingDataPovider>(context, listen: false);
    final dish = Provider.of<Dish>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: const Icon(
            Icons.favorite_border_sharp,
            color: Colors.grey,
          ),
          onTap: () {
            Provider.of<DishAddingDataPovider>(context, listen: false).addItem(
              dishId: dish.id,
              price: dish.price,
              title: dish.name,
              imgUrl: dish.imgUrl,
            );
          },
        )
      ],
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
