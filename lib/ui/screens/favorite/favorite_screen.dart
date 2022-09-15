import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          height: 50,
          color: Colors.red,
        ),
      ),
    );
  }
}
