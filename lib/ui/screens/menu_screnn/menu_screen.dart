import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_app.dart';
import '../../widgets/header_widget/header_widget.dart';
import 'menu_model.dart';

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
    final dishsLength = context.watch<MenuModel>().menuDishs.length;
    return Expanded(
      child: GridView.builder(
        itemCount: dishsLength,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 345.0,
        ),
        itemBuilder: (context, index) => (dishsLength != 0)
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
    final itemImgUrl = context.watch<MenuModel>().menuDishs[index].imgUrl;
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
          const _CartItemButtonFavoritWidget(),
          _CartItemContainerTextWidget(index: index),
        ],
      ),
    );
  }
}

class _CartItemButtonFavoritWidget extends StatelessWidget {
  const _CartItemButtonFavoritWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.read<MenuModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: const Icon(
            Icons.favorite_border_sharp,
            color: Colors.grey,
          ),
          onTap: () => model.addToBox(),
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
    final item = context.read<MenuModel>().menuDishs[index];
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
    final itemImgUrl = context.watch<MenuModel>().menuDishs[index].imgUrl;
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
