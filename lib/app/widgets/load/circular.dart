import 'package:flutter/material.dart';

import '../../theme/theme_app.dart';

class CircularWidget extends StatelessWidget {
  const CircularWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ThemeAppColor.kAccent,
        strokeWidth: 3,
      ),
    );
  }
}
