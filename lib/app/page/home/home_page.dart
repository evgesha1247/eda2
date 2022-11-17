import 'package:flutter/material.dart';
import 'package:text/app/page/home/home_header_section.dart';
import 'package:text/app/page/home/home_popular_section.dart';
import 'package:text/app/page/home/home_recommended_suction.dart';
import '../../theme/theme_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeaderWidget(),
            const HomePopularSection(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const RecommendedSuction()
          ],
        ),
      )
    ]);
  }
}
