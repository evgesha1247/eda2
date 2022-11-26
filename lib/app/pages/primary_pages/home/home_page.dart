import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/controllers/cart_controller.dart';
import '../../../theme/theme_app.dart';
import 'home_header_section.dart';
import 'home_popular_section.dart';
import 'home_recommended_suction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    Get.find<CartController>();
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeaderWidget(),
            const HomePopularSection(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const RecommendedSuction()
          ],
        ),
      )
    ]);
  }
}
