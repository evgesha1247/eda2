import 'package:flutter/material.dart';

enum SortMethod { lowToHigh, highToLow, aToZ, zToA, reset }

enum RenderingMethod { list, grid }

class FilterModel {
  final String text;
  final IconData icon;
  const FilterModel({
    required this.text,
    required this.icon,
  });
}
