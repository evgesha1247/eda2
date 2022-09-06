import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/home_screen/home_model.dart';

class HomeHederWidget extends StatelessWidget {
  const HomeHederWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final togFilter = context.select((HomeModel e) => e.togFilter);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: AnimatedContainer(
        duration: const Duration(seconds: 0),
        curve: Curves.fastOutSlowIn,
        height: togFilter ? 130 : 33,
        child: togFilter
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(child: _SearchWidget()),
                      SizedBox(width: 10),
                      _FilterButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Row(children: [
                            Text('позиция 1'),
                            Switch(onChanged: (bool value) {}, value: false)
                          ]),
                          Row(children: [
                            Text('позиция 2'),
                            Switch(onChanged: (bool value) {}, value: false)
                          ]),
                          Text('...')
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: const [
                              Center(child: Text('от 0\$ ')),
                              Text(' до 999\$'),
                            ],
                          ),
                          RangeSlider(
                            values: RangeValues(0.3, 0.7),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: _SearchWidget()),
                  SizedBox(width: 10),
                  _FilterButton(),
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
