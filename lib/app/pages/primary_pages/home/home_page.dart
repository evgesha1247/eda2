import 'package:flutter/material.dart';

import '../../../theme/theme_app.dart';
import 'home_body/home_popular_section.dart';
import 'home_body/home_recommended_suction.dart';
import 'home_header.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderHome(),
          const PopularHome(),
          SizedBox(height: ThemeAppSize.kInterval24),
          const RecommendedHome(),
        ],
      ),
    );
  }
}
