import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:text/object/user_object.dart';
import 'package:text/ui/widgets/text/big_text.dart';
import '../../theme/theme_app.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          _AuthTextFieldWidget(),
          _AuthButtonWidget(),
        ],
      ),
    );
  }
}
final _controllerName = TextEditingController();
final _controllerAge = TextEditingController();
final _controllerAdress = TextEditingController();
final _controllerPhone = TextEditingController();

class _AuthTextFieldWidget extends StatelessWidget {
  const _AuthTextFieldWidget();
  @override
  Widget build(BuildContext context) {
    InputBorder styleSearch = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ThemeAppSize.kInterval12)),
      borderSide: const BorderSide(style: BorderStyle.solid),
    );
    InputDecoration decoration({required name, required icon}) =>
        InputDecoration(
          isDense: true,
          fillColor: ThemeAppColor.kBGColor,
          prefixIcon: Icon(icon, color: ThemeAppColor.kFrontColor),
          hintText: name,
          enabledBorder: styleSearch,
          focusedBorder: styleSearch,
        );

    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Column(
        children: [
          TextField(
            controller: _controllerName,
            cursorColor: ThemeAppColor.kFrontColor,
            decoration: decoration(name: 'Ivan', icon: Icons.person),
          ),
          SizedBox(height: ThemeAppSize.kInterval24),
          TextField(
            controller: _controllerAge,
            cursorColor: ThemeAppColor.kFrontColor,
            decoration: decoration(name: 'age', icon: Icons.summarize),
          ),
          SizedBox(height: ThemeAppSize.kInterval24),
          TextField(
            controller: _controllerAdress,
            cursorColor: ThemeAppColor.kFrontColor,
            decoration: decoration(name: '23 Chapel Hill', icon: Icons.home),
          ),
          SizedBox(height: ThemeAppSize.kInterval24),
          TextField(
            controller: _controllerPhone,
            keyboardType: TextInputType.phone,
            cursorColor: ThemeAppColor.kFrontColor,
            decoration: decoration(name: '1-234-567-890', icon: Icons.phone),
          ),
        ],
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();
  @override
  Widget build(BuildContext context) {

Future<void> createUser(User user) async {
      try {
        final docUser = FirebaseFirestore.instance.collection('users').doc();
        user.id = docUser.id;
        final json = user.toJson();
        await docUser.set(json);
        print(docUser);
      } catch (e) {
        print(e);
      }
    }

    return GestureDetector(
      onTap: () {
        final user = User(
          name: _controllerName.text,
          age: int.parse(_controllerAge.text),
          address: _controllerAdress.text,
          telephone: _controllerPhone.text,
        );
        createUser(user);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BigText(
            text: 'login',
            color: ThemeAppColor.kFrontColor,
          ),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
