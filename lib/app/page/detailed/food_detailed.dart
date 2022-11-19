import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/controllers/popular_product_controller.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/icon/menu_icon.dart';
import 'package:text/app/widgets/text/my_text.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/text/expandable_text.dart';

class FoodDetailedPage extends StatelessWidget {

  late final ProductModel item;
  FoodDetailedPage({super.key}) {
    item = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _DetailedPageBody(item: item),
      bottomNavigationBar: _BottomWidget(item: item),
    );
  }
}

class _DetailedPageBody extends StatelessWidget {
  const _DetailedPageBody({required this.item});
  final ProductModel item;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          backgroundColor: ThemeAppColor.kFrontColor,
          expandedHeight: 280,
          toolbarHeight: 120,
          elevation: 0,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () => Get.back(),
              child:
                  const CustomButtonIcon(icon: Icon(Icons.arrow_back_ios_new)),
            ),
            GestureDetector(
              onTap: () {},
              child: const CustomButtonIcon(
                icon: Icon(Icons.favorite_outline),
                colorBorder: ThemeAppColor.kBGColor,
              ),
            )
          ]),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              "${AppConstansts.BASE_URL}/uploads/${item.img!}",
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
                    text: item.name!,
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ExpandableTextWidget(
                    text: item.description!,
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

class _BottomWidget extends StatelessWidget {
  const _BottomWidget({required this.item});

  final ProductModel item;
  @override
  Widget build(BuildContext context) {

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
          const _AddAndSubDishWidget(),
          _TotalPriceWidget(item: item),
        ],
      ),
    );
  }
}

class _TotalPriceWidget extends StatelessWidget {
  _TotalPriceWidget({required this.item});
  final ProductModel item;
  final controller = Get.find<PopularProductController>();
  @override

  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => controller.addProduct(item),
      child: Container(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        decoration: BoxDecoration(
          color: ThemeAppColor.kAccent,
          borderRadius: ThemeAppFun.decoration(
            radius: ThemeAppSize.kRadius12,
          ),
        ),
        child: BigText(
          text: '\$ ${item.price} | Go to cart',
          color: ThemeAppColor.kWhite,
          size: ThemeAppSize.kFontSize20,

        ),
      ),
    );
  }
}

class _AddAndSubDishWidget extends StatelessWidget {
  const _AddAndSubDishWidget();

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().initCount(Get.find<CartController>());
    return Container(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      decoration: BoxDecoration(
        color: ThemeAppColor.kBGColor,
        borderRadius: ThemeAppFun.decoration(
          radius: ThemeAppSize.kRadius12,
        ),
      ),
      child: GetBuilder<PopularProductController>(
        builder: (pularProduct) {
          return Row(
            children: [
              GestureDetector(
                onTap: () => pularProduct.setCountProduct(false),
                child: const Icon(
                  Icons.remove,
                  color: ThemeAppColor.kFrontColor,
                ),
              ),
              SizedBox(width: ThemeAppSize.kInterval5),
              SmallText(
                text: '${pularProduct.countProduct}',
                color: ThemeAppColor.kFrontColor,
              ),
              SizedBox(width: ThemeAppSize.kInterval5),
              GestureDetector(
                onTap: () => pularProduct.setCountProduct(true),
                child: const Icon(
                  Icons.add,
                  color: ThemeAppColor.kFrontColor,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
