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
      SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          children: [
            const HomeHeader(),
            const HomePopular(),
            SizedBox(height: ThemeAppSize.kInterval24),
            const HomeRecommended(),
          ],
        ),
      )
    ]);
  }
}
