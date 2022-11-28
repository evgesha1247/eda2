import 'package:flutter/material.dart';
import 'package:text/app/theme/theme_app.dart';
import 'home_header_section.dart';
import 'home_popular_section.dart';
import 'home_recommended_suction.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeHeader(),
            HomePopular(),
            HomeRecommended(),
          ],
        ),
      )
    ]);
  }
}
