import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/home_screen/home_screen.dart';
import '../../widgets/footer_widget/footer_screen_model.dart';
import '../../widgets/footer_widget/footer_screen.dart';
import '../home_screen/home_model.dart';

class ScreensFactory {
  Widget makeHomeApp() => ChangeNotifierProvider(
        create: (context) => FooterScreenModel(),
        child: const FooterScreen(),
      );

  /////// SCREENS ///////
  Widget makeHomeScreen() => ChangeNotifierProvider(
        create: (context) => HomeModel(),
        child: const HomeScreen(),
      );
}
