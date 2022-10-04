// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/widgets/header_widget/header_model.dart';
import '../../theme/theme_app.dart';

const _height = 33.0;

class HederWidget extends StatelessWidget {
  const HederWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kRadius)),
      borderSide: const BorderSide(style: BorderStyle.none),
    );
    return SliverAppBar(
      leading: const SizedBox.shrink(),
      collapsedHeight: 80,
      floating: true,
      pinned: false,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        title: Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: FittedBox(
            child: LimitedBox(
              maxWidth: 400,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: _height,
                          child: TextField(
                            cursorColor: ThemeAppColor.kAccent,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 235, 235, 235),
                              prefixIcon: const Icon(Icons.search,
                                  color: ThemeAppColor.kAccent),
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
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: ThemeAppColor.kBGColor,
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
      side: const BorderSide(width: 2, color: ThemeAppColor.kAccent),
      shape: RoundedRectangleBorder(
        borderRadius: ThemeAppFun.decoration(),
      ),
    );
    final model = context.read<HeaderModel>();
    return ElevatedButton(
      style: styleBut,
      onPressed: () => model.showCart(context),
      child: const SizedBox(
        height: _height,
        child: Icon(Icons.shopping_cart, color: ThemeAppColor.kAccent),
      ),
    );
  }
}
