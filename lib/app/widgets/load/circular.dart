import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CircularWidget extends StatelessWidget {
  const CircularWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        //color: context.theme.primaryColor,
        strokeWidth: 3,
      ),
    );
  }
}
