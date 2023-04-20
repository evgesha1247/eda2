import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularWidget extends StatelessWidget {
  final double? value;
  const CircularWidget({super.key, this.value});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: value,
        color: context.theme.primaryColor,
        strokeWidth: 3,
      ),
    );
  }
}
