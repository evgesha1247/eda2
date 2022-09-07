import 'package:flutter/material.dart';
import '../../widgets/home_header_widget/home_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: MediaQuery.of(context).size.width > 300
                ? Column(
                    children: const [
                      HomeHederWidget(),
                      HomeBodyWidget(),
                    ],
                  )
                : const HomeBodyWidget(),
          ),
        ),
      );
}

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, i) => const Card(
          child: Center(
            child: Text('еда'),
          ),
        ),
      ),
    );
  }
}
