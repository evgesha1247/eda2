import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_bottom.dart';
import 'package:text/app/pages/primary_pages/guiding/guiding_stack_page.dart';

class GuidingPage extends StatelessWidget {
  const GuidingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Scaffold(
      body: const GuidingStackPage(),
      bottomNavigationBar: (width >= 370) ? const GuidingBottomWidget() : null,
      floatingActionButton: (width < 370) ? const FlotingWidget() : null,
    );
  }
}
