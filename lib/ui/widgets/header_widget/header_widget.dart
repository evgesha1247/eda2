// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/widgets/header_widget/header_model.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import 'package:text/ui/widgets/text/small_text.dart';
import '../../../object/cart_object.dart';
import '../../theme/theme_app.dart';

class HederWidget extends StatelessWidget {
  const HederWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius)),
      borderSide: const BorderSide(style: BorderStyle.none),
    );

    final number = context.watch<CartModel>().number().toString();
    return SliverAppBar(
      leading: const SizedBox.shrink(),
      collapsedHeight: 68,
      floating: true,
      pinned: false,
      snap: true,
      backgroundColor: ThemeAppColor.kFrontColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        title: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              child: LimitedBox(
                maxWidth: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 33,
                        child: TextField(
                          cursorColor: ThemeAppColor.kFrontColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            filled: true,
                            fillColor: ThemeAppColor.kBGColor,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: ThemeAppColor.kFrontColor,
                            ),
                            hintText: 'Search',
                            enabledBorder: styleSearch,
                            focusedBorder: styleSearch,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ThemeAppSize.kInterval12),
                    const _FilterButtonWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      actions: number != '0'
          ? [
              Stack(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: ThemeAppFun.decoration(radius: 30),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: BigText(
                          text: number,
                          color: ThemeAppColor.kBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          : [],
    );
  }
}

class _FilterButtonWidget extends StatelessWidget {
  const _FilterButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final styleBut = ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      side: const BorderSide(
        width: 2,
        color: ThemeAppColor.kBGColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeAppFun.decoration(),
      ),
    );

    final headerModel = context.read<HeaderModel>();

    return Stack(
      children: [
        ElevatedButton(
          style: styleBut,
          onPressed: () => headerModel.showCart(context),
          child: const SizedBox(
            height: 33,
            child: Icon(
              Icons.shopping_cart,
              color: ThemeAppColor.kBGColor,
            ),
          ),
        ),
      ],
    );
  }
}
