import 'package:flutter/material.dart';

import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatefulWidget {
  const DishDetailedScreen({Key? key}) : super(key: key);
  @override
  State<DishDetailedScreen> createState() => _DishDetailedScreenState();
}

class _DishDetailedScreenState extends State<DishDetailedScreen> {
  DishDetailedModel? model;
  @override
  void didChangeDependencies() {
    if (model == null) {
      final key = ModalRoute.of(context)!.settings.arguments as int;
      model = DishDetailedModel(key: key);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
