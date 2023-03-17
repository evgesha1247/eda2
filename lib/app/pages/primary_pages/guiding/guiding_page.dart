import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_bottom.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_stack_page.dart';

import '../../../theme/theme_app.dart';

class GuidingPage extends StatelessWidget {
  const GuidingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final bool widthStatus = context.width >= ThemeAppSize.kMaxMinWidth;
    return Scaffold(
      body: const StackPageGuiding(),
      bottomNavigationBar: (widthStatus) ? const BottomGuiding() : null,
      floatingActionButton: (!widthStatus) ? const FlotingGuiding() : null,
    );
  }
}
