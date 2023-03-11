import 'package:flutter/material.dart';
import 'favorite_body.dart';
import 'favorite_header.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [
          FavoritHeader(),
          FavoriteBody(),
      ],
    );
  }
}
