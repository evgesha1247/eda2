import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/guiding_screen/guiding_model.dart';
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
                _FilterButton(),
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
    const InputBorder styleSerch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeApp.kRadius)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return const SizedBox(
      height: ThemeApp.kHeight,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          filled: true,
          fillColor: Color.fromARGB(255, 235, 235, 235),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search',
          enabledBorder: styleSerch,
          focusedBorder: styleSerch,
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key? key}) : super(key: key);
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
    final currentIndexTab =
        context.select((GuidingScreenModel e) => e.currentIndexTab);
    switch (currentIndexTab) {
      case 0:
        return ElevatedButton(
          style: styleBut,
          onPressed: () {},
          child: const SizedBox(
              height: ThemeApp.kHeight,
              child: Icon(Icons.tune, color: ThemeApp.kAccent)),
        );

      case 1:
        return ElevatedButton(
          style: styleBut,
          onPressed: () {},
          child: const SizedBox(
              height: ThemeApp.kHeight,
              child: Icon(Icons.tune, color: Color.fromARGB(255, 30, 1, 247))),
        );
    }
    return const SizedBox.shrink();
  }
}
