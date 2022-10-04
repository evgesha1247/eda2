import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'package:text/ui/widgets/big_text.dart';
import '../../../object/cart_object.dart';
import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatefulWidget {
  const DishDetailedScreen({Key? key}) : super(key: key);
  @override
  State<DishDetailedScreen> createState() => _DishDetailedScreenState();
}

class _DishDetailedScreenState extends State<DishDetailedScreen> {
  DishDetailedModel? _model;
  @override
  void didChangeDependencies() {
    if (_model == null) {
      final dishKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = DishDetailedModel(dishKey: dishKey);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DishDetailedModel? model = _model;
    if (model != null) {
      return ChangeNotifierProvider(
        create: (context) => model,
        child: const DishDetaild(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class DishDetaild extends StatelessWidget {
  const DishDetaild({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Column(
            children: [
              const _StackImgAndContent(),
              SizedBox(height: ThemeAppSize.kInterval12),
              const _DishDetailedDescription(),
              const _MarcetWidget(),
              SizedBox(height: ThemeAppSize.kInterval12),
              const _DishDetailedButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarcetWidget extends StatelessWidget {
  const _MarcetWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: ThemeAppFun.decoration(),
        color: Colors.white,
      ),
      height: 3.5,
      width: 30,
    );
  }
}

class _StackImgAndContent extends StatelessWidget {
  const _StackImgAndContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _DishDetailedContainer(),
        _DishDetailedImg(),
        _DishDetailedButtonBack(),
      ],
    );
  }
}

class _DishDetailedImg extends StatelessWidget {
  const _DishDetailedImg({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final imgUrl = model.dish?.imgUrl ?? 'assets/imgs/food2.png';
    return Align(
      child: Image.asset(imgUrl,
          height: 200,
          width: MediaQuery.of(context).size.width * 0.6,
          fit: BoxFit.contain,
          alignment: Alignment.topCenter),
    );
  }
}

class _DishDetailedContainer extends StatelessWidget {
  const _DishDetailedContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: ThemeAppFun.decoration(),
        color: ThemeAppColor.kFrontColor,
      ),
      margin: const EdgeInsets.only(top: 60),
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: const _DishDetailedContainerText(),
    );
  }
}

class _DishDetailedContainerText extends StatelessWidget {
  const _DishDetailedContainerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final title = model.dish?.name ?? '## название отсудствует ##';
    final price = model.dish?.price ?? 00;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _ButtBookmark(),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: BigText(text: title)),
            Container(
              decoration: BoxDecoration(
                borderRadius: ThemeAppFun.decoration(),
                color: ThemeAppColor.kAccent,
              ),
              child: Padding(
                padding: EdgeInsets.all(ThemeAppSize.kInterval12),
                child: BigText(text: '$price\$'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtBookmark extends StatelessWidget {
  const _ButtBookmark({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final isFovarit = model.dish?.isFovarit ?? false;
    return GestureDetector(
      onTap: () => model.toggFovarit(),
      child: Align(
        alignment: Alignment.topRight,
        child: isFovarit
            ? const Icon(Icons.favorite, color: Colors.red)
            : const Icon(Icons.favorite_border, color: ThemeAppColor.kWhite),
      ),
    );
  }
}

class _DishDetailedDescription extends StatelessWidget {
  const _DishDetailedDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final description = model.dish?.description ?? '';
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: 'description'),
              SizedBox(height: ThemeAppSize.kInterval12),
              BigText(text: description),
            ],
          ),
        ),
      ),
    );
  }
}

class _DishDetailedButtonBar extends StatelessWidget {
  const _DishDetailedButtonBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dishModel = context.watch<DishDetailedModel>();
    final cartModel = context.watch<CartModel>();
    final dishkey = dishModel.dish?.id ?? '';
    final number = cartModel.namber(dishkey);
    final subTotal = cartModel.subTotal(dishkey).toStringAsFixed(2);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: ThemeAppFun.decoration(),
        color: ThemeAppColor.kFrontColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cartModel.addItem(
                          dishId: dishModel.dish?.id,
                          price: dishModel.dish?.price,
                          name: dishModel.dish?.name,
                          imgUrl: dishModel.dish?.imgUrl,
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 22,
                        color: ThemeAppColor.kBlack,
                      ),
                    ),
                    SizedBox(width: ThemeAppSize.kInterval12),
                    BigText(text: '$number'),
                    SizedBox(width: ThemeAppSize.kInterval12),
                    GestureDetector(
                      onTap: () {
                        cartModel.updataSubOne(dishkey);
                      },
                      child: const Icon(Icons.remove_circle_outline,
                          size: 22, color: ThemeAppColor.kBlack),
                    )
                  ],
                ),
                Row(children: [BigText(text: 'total : $subTotal\$ ')])
              ],
            ),
            SizedBox(height: ThemeAppSize.kInterval12),
            GestureDetector(
              onTap: () => dishModel.showCart(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: ThemeAppFun.decoration(),
                  color: ThemeAppColor.kAccent,
                ),
                child: Center(
                  child: BigText(text: 'show cart'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DishDetailedButtonBack extends StatelessWidget {
  const _DishDetailedButtonBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.read<DishDetailedModel>();
    return GestureDetector(
      onTap: () => model.showMenu(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: ThemeAppFun.decoration(),
          color: ThemeAppColor.kFrontColor,
        ),
        padding: EdgeInsets.only(
          top: ThemeAppSize.kInterval12,
          bottom: ThemeAppSize.kInterval12,
          left: ThemeAppSize.kInterval12 + 10,
          right: ThemeAppSize.kInterval12,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ThemeAppColor.kAccent,
        ),
      ),
    );
  }
}
