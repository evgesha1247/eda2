import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/footer_widget/footer_screen_model.dart';
import '../../widgets/footer_widget/footer_screen.dart';

class ScreensFactory {
  Widget makeHomeWidget() => ChangeNotifierProvider(
        create: (context) => FooterScreenModel(),
        child: const FooterScreen(),
      );
}
