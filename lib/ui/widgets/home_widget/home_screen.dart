import 'package:flutter/material.dart';

import '../header_widget/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) => Scaffold(
        body: Column(
          children: const [
            HomeHederWidget(),
            HomeBodyWidget(),
          ],
        ),
      );
}

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Width: ${constraints.maxWidth}",
                style: Theme.of(context).textTheme.headline4),
            Text("Height: ${constraints.maxHeight}",
                style: Theme.of(context).textTheme.headline4)
          ],
        ),
      ),
    );
  }
}
