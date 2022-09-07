import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/home_screen/home_model.dart';
import '../../theme/theme_app.dart';

class HomeHederWidget extends StatefulWidget {
  const HomeHederWidget({Key? key}) : super(key: key);
  @override
  State<HomeHederWidget> createState() => _HomeHederWidgetState();
}

class _HomeHederWidgetState extends State<HomeHederWidget> {
  @override
  Widget build(BuildContext context) {
    final togFilter = context.select((HomeModel e) => e.togFilter);
    return Padding(
      padding: const EdgeInsets.all(ThemeApp.kIndent),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: _SearchWidget()),
              SizedBox(width: ThemeApp.kIndent),
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
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const InputBorder styleSerch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeApp.kIndent)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return const SizedBox(
      height: ThemeApp.kHeight,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: ThemeApp.kIndent),
          isDense: true,
          isCollapsed: true,
          filled: true,
          fillColor: Color.fromARGB(255, 235, 235, 235),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          label: Text('Search'),
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
          borderRadius: BorderRadius.circular(ThemeApp.kIndent)),
    );

    final model = context.read<HomeModel>();
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
