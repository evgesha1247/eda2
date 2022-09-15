import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/menu_screnn/menu_model.dart';
import '../../../object/dish_model.dart';
import '../../theme/theme_app.dart';
import '../../widgets/header_widget/header_widget.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Column(
      children: mediaQuery < 370
          ? [const _MenuBodyWidget()]
          : [const HederWidget(), const _MenuBodyWidget()],
    );
  }
}

class _MenuBodyWidget extends StatelessWidget {
  const _MenuBodyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishs = context.watch<DishModel>().items;
    return Expanded(
      child: GridView.builder(
        itemCount: dishs.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 345.0,
        ),
        itemBuilder: (context, index) => (dishs.isNotEmpty)
            ? _CartItemWidget(index: index)
            : const _ListIsEmpty(),
      ),
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  const _CartItemWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return (mediaQuery > 370)
        ? _CartItemContainerFullWidget(index: index)
        : _CartItemContainerWidget(index: index);
  }
}

class _CartItemContainerFullWidget extends StatelessWidget {
  const _CartItemContainerFullWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _CartItemContainerWidget(index: index),
        _CartItemImgWidget(index: index),
      ],
    );
  }
}

class _CartItemContainerWidget extends StatelessWidget {
  const _CartItemContainerWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemImgUrl = context.read<DishModel>().items[index].imgUrl;
    return Container(
        decoration: BoxDecoration(
          color: ThemeApp.kFrontColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(ThemeApp.kRadius),
          ),
          image: MediaQuery.of(context).size.width < 370
              ? DecorationImage(
                  image: AssetImage(itemImgUrl),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter)
              : null,
        ),
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: _CartItemContainerContentWidget(index: index));
  }
}

class _CartItemContainerContentWidget extends StatelessWidget {
  const _CartItemContainerContentWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _CartItemButtonFavoritWidget(index: index),
          _CartItemContainerTextWidget(index: index),
        ],
      ),
    );
  }
}

class _CartItemButtonFavoritWidget extends StatelessWidget {
  const _CartItemButtonFavoritWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<MenuModel>();
    final isFovarit = model.isFovarit;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: Icon(
            Icons.favorite_border_sharp,
            color: isFovarit ? Colors.red : Colors.grey,
          ),
          onTap: () => model.addFavorit(index),
        )
      ],
    );
  }
}

class _CartItemContainerTextWidget extends StatelessWidget {
  const _CartItemContainerTextWidget({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final item = context.read<DishModel>().items[index];
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              item.name,
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
            '\$ ${item.price}',
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

class _CartItemImgWidget extends StatelessWidget {
  const _CartItemImgWidget({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemImgUrl = context.read<DishModel>().items[index].imgUrl;
    return Positioned(
      child: Image.asset(
        itemImgUrl,
        fit: BoxFit.cover,
        width: 110,
      ),
    );
  }
}

class _ListIsEmpty extends StatelessWidget {
  const _ListIsEmpty({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('нет товаров '),
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
