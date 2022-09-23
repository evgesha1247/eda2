// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/widgets/header_widget/header_model.dart';
import '../../theme/theme_app.dart';

class HederWidget extends StatefulWidget {
  const HederWidget({Key? key}) : super(key: key);
  @override
  State<HederWidget> createState() => _HederWidgetState();
}

class _HederWidgetState extends State<HederWidget> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: LimitedBox(
        maxWidth: 400,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(child: _SearchWidget()),
                SizedBox(width: ThemeApp.kInterval),
                _FilterButtonWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeApp.kRadius)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    const inputDecor = InputDecoration(
      contentPadding: EdgeInsets.zero,
      isDense: true,
      filled: true,
      fillColor: Color.fromARGB(255, 235, 235, 235),
      prefixIcon: Icon(Icons.search, color: Colors.grey),
      hintText: 'Search',
      enabledBorder: styleSearch,
      focusedBorder: styleSearch,
    );
    return const SizedBox(
      height: ThemeApp.kHeight,
      child: TextField(decoration: inputDecor),
    );
  }
}

class _FilterButtonWidget extends StatelessWidget {
  const _FilterButtonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final styleBut = ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      side: const BorderSide(width: 2, color: ThemeApp.kAccent),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeApp.kRadius)),
    );
    final model = context.read<HeaderModel>();
    return ElevatedButton(
      style: styleBut,
      onPressed: () => model.showCart(context),
      child: const SizedBox(
        height: ThemeApp.kHeight,
        child: Icon(Icons.tune, color: ThemeApp.kAccent),
      ),
    );
  }
}
