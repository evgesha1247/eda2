import 'package:flutter/material.dart';
import '../../../theme/theme_app.dart';
import 'auth_body.dart';
import 'auth_bottom.dart';
import 'auth_header.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ThemeAppSize.kInterval12),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [

                const HeaderAuth(),
                SizedBox(height: ThemeAppSize.kInterval12),
                const BodyAuth(),
                SizedBox(height: ThemeAppSize.kInterval12),
                const BottomAuth(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
