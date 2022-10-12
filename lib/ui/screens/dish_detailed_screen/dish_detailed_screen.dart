import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/icon/my_icon.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';
import '../../../object/cart_object.dart';
import '../../widgets/text/expandable_text.dart';
import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatefulWidget {
  final int dishKey;
  const DishDetailedScreen({Key? key, required this.dishKey}) : super(key: key);
  @override
  State<DishDetailedScreen> createState() => _DishDetailedScreenState();
}

class _DishDetailedScreenState extends State<DishDetailedScreen> {
  late final DishDetailedModel _model;
  @override
  void initState() {
    super.initState();
    _model = DishDetailedModel(dishKey: widget.dishKey);
  }

  @override
  Widget build(BuildContext context) {
    DishDetailedModel? model = _model;
    return ChangeNotifierProvider(
      create: (context) => model,
      child: const DishDetaild(),
    );
  }
}

class DishDetaild extends StatelessWidget {
  const DishDetaild({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _DishDetailedBody(),
      bottomNavigationBar: _DishDetailedBottomBarWidget(),
    );
  }
}
class _DishDetailedBody extends StatelessWidget {
  const _DishDetailedBody();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final name = model.dish?.name ?? '404';
    final description = model.dish?.description ?? '404';
    final imgUrl = model.dish?.imgUrl ?? ThemeAppImgURL.imgURL1;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          backgroundColor: ThemeAppColor.kFrontColor,
          expandedHeight: 280,
          toolbarHeight: 120,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () => model.showMenu(context),
                  child: const MyIcon(icon: Icons.arrow_back_ios_new)),
              GestureDetector(
                onTap: () => model.toggFovarit(),
                child: model.dish?.isFavorit == true
                    ? const MyIcon(
                        icon: Icons.favorite,
                        iconColor: ThemeAppColor.kAccent,
                      )
                    : const MyIcon(icon: Icons.favorite_border),
              ),
            ],
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              imgUrl,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeAppColor.kBGColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ThemeAppSize.kRadius20 * 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: ThemeAppSize.kInterval12),
                  child: BigText(
                    text: name,
                    color: ThemeAppColor.kFrontColor,
                    size: ThemeAppSize.kFontSize25,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(ThemeAppSize.kInterval24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BigText(
                  text: 'Introduce',
                  color: ThemeAppColor.kFrontColor,
                  //size: ThemeAppSize.kFontSize18,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ExpandableTextWidget(
                    text: description,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DishDetailedBottomBarWidget extends StatelessWidget {
  const _DishDetailedBottomBarWidget();
  @override
  Widget build(BuildContext context) {
    final cartModel = context.watch<CartModel>();
    final dishModel = context.watch<DishDetailedModel>();
    final dishkey = dishModel.dish?.id ?? '';
    final number = cartModel.namber(dishkey);
    final subTotal = cartModel.subTotal(dishkey).toStringAsFixed(1);
    return Container(
      height: ThemeAppSize.kDetaildButtomContainer,
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      decoration: BoxDecoration(
        color: ThemeAppColor.kFrontColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeAppSize.kRadius20 * 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(ThemeAppSize.kInterval12),
            decoration: BoxDecoration(
              color: ThemeAppColor.kBGColor,
              borderRadius: ThemeAppFun.decoration(
                radius: ThemeAppSize.kRadius12,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => cartModel.updataSubOne(dishkey),
                  child: const Icon(
                    Icons.remove,
                    color: ThemeAppColor.kFrontColor,
                  ),
                ),
                SizedBox(width: ThemeAppSize.kInterval5),
                SmallText(
                  text: '$number',
                  color: ThemeAppColor.kFrontColor,
                ),
                SizedBox(width: ThemeAppSize.kInterval5),
                GestureDetector(
                  onTap: () => cartModel.addItem(
                      dishId: dishModel.dish?.id,
                      price: dishModel.dish?.price,
                      name: dishModel.dish?.name,
                      imgUrl: dishModel.dish?.imgUrl),
                  child: const Icon(
                    Icons.add,
                    color: ThemeAppColor.kFrontColor,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => dishModel.showCart(context),
            child: Container(
              padding: EdgeInsets.all(ThemeAppSize.kInterval12),
              decoration: BoxDecoration(
                color: ThemeAppColor.kAccent,
                borderRadius: ThemeAppFun.decoration(
                  radius: ThemeAppSize.kRadius12,
                ),
              ),
              child: Row(
                children: [
                  SmallText(
                    text: '\$ $subTotal | ',
                    color: ThemeAppColor.kWhite,
                  ),
                  BigText(
                    text: 'Go to cart',
                    color: ThemeAppColor.kWhite,
                    size: ThemeAppSize.kFontSize20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
