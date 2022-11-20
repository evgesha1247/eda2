import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/models/products_model.dart';
import 'package:text/app/page/detailed/body_detailed.dart';
import 'package:text/app/page/detailed/bottom_detailed.dart';
import 'header_detailed.dart';

class FoodDetailedPage extends StatelessWidget {
  late final ProductModel item;
  FoodDetailedPage({super.key}) {
    item = Get.arguments;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
      slivers: [
          HeaderDetailed(item: item),
          BodyDetailed(description: item.description!),
        ],
      ),
      bottomNavigationBar: BottomDetailed(item: item),
    );
  }
}
