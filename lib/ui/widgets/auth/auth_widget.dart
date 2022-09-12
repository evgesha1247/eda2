import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeApp.kFrontColor,
            ThemeApp.kBGColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: const [
              // Lottie.network(
              //     'https://assets2.lottiefiles.com/private_files/lf30_3ghvm6sn.json'),
            ],
          ),
        ),
      ),
    );
  }
}
