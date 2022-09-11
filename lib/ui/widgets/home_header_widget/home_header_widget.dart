import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/menu_home_screen/menu_home_model.dart';
import '../../theme/theme_app.dart';

class HomeHederWidget extends StatefulWidget {
  const HomeHederWidget({Key? key}) : super(key: key);
  @override
  State<HomeHederWidget> createState() => _HomeHederWidgetState();
}

class _HomeHederWidgetState extends State<HomeHederWidget> {
  @override
  Widget build(BuildContext context) {
    final togFilter = context.select((MenuHomeModel e) => e.togFilter);
    return FittedBox(
      child: LimitedBox(
        maxWidth: 400,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _SearchWidget()),
                SizedBox(width: ThemeApp.kInterval),
                _FilterButton(),
              ],
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 500),
              firstChild: const _Filter(),
              secondChild: const SizedBox.shrink(),
              //2
              crossFadeState: togFilter
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
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

    final model = context.read<MenuHomeModel>();
    return ElevatedButton(
      style: styleBut,
      onPressed: model.togFilterFun,
      child: const SizedBox(
          height: ThemeApp.kHeight,
          child: Icon(Icons.tune, color: ThemeApp.kAccent)),
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: true,
      onChanged: (value) {},
    );
  }
}
