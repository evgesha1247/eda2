import 'package:flutter/material.dart';
import 'menu_body.dart';
import 'menu_filter.dart';
import 'menu_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: MediaQuery.of(context).size.width >= 370
            ? [
                MenuHeader(),
                FilterWidget(),
                MenuBodyWidget(),
              ]
            : [
                MenuBodyWidget(),
              ],
      ),
    );
  }
}
