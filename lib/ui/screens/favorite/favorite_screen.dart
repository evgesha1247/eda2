import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../object/dish_adding.dart';

class FavoriteScrenn extends StatelessWidget {
  const FavoriteScrenn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishData = Provider.of<DishAddingDataPovider>(context, listen: true);
    final dishItem = dishData.dishAddingItem.values.toList();
    final item = dishData.dishAddingItem.entries.map((e) => e.value);
    return Center(
      child: ListView.builder(
        itemCount: dishItem.length,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          height: 50,
          color: Colors.red,
        ),
      ),
    );
  }
}
