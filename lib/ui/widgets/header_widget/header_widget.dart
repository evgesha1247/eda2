import 'package:flutter/material.dart';

class HomeHederWidget extends StatelessWidget {
  const HomeHederWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _SearchWidget(),
            SizedBox(width: 10),
            _DeliveryButton(),
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
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return const Expanded(
      child: TextField(
        decoration: InputDecoration(
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

class _DeliveryButton extends StatelessWidget {
  const _DeliveryButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final styleBut = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.transparent,
      side: const BorderSide(width: 2, color: Color(0xffF7C701)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
    return ElevatedButton(
      style: styleBut,
      child: const Icon(Icons.delivery_dining_sharp, color: Color(0xffF7C701)),
      onPressed: () {},
    );
  }
}
