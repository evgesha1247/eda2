import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/home_screen/home_model.dart';

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
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: _SearchWidget()),
              SizedBox(width: 10),
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
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return const SizedBox(
      height: 33,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
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
      side: const BorderSide(width: 2, color: Color(0xffF7C701)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );

    final model = context.read<HomeModel>();
    return ElevatedButton(
      style: styleBut,
      onPressed: model.togFilterFun,
      child: const Icon(Icons.tune, color: Color(0xffF7C701)),
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
