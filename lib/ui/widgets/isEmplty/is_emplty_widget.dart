import 'package:flutter/material.dart';
import '../../theme/theme_app.dart';

class IsEmpltyWidget extends StatelessWidget {
  const IsEmpltyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'dishes not found',
            style: ThemeApp.style(fW: FontWeight.w400, size: 30),
          ),
          Text(
            '404 •_•',
            style: ThemeApp.style(size: 20, colors: ThemeApp.kAccent),
          ),
        ],
      ),
    );
  }
}
