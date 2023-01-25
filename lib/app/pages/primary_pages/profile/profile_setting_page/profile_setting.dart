import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../theme/theme_app.dart';
import '../../../../widgets/text/my_text.dart';
import '../profile_page.dart';

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Column(
        children: [
        const _TitleSetting(title: 'Setting'),
          _SettingBody(),
          _ButtonSave(),
        ],
      ),
    );
  }
}

class _TitleSetting extends StatelessWidget {
  final String title;
  const _TitleSetting({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Btn(),
        const SizedBox(),
        const Spacer(),
        BigText(text: title),
        const Spacer(),
        _ButtonClose(),
      ],
    );
  }
}

class Btn extends StatelessWidget {
  const Btn({super.key});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Get.updateLocale(const Locale('en', 'US')),
      child: const Text('Korean'),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}



class _SettingBody extends StatelessWidget {
  _SettingBody();
  final _ = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final List cTextField = [_.cName, _.cPhone, _.cPhotoURL];
    final List cTitle = ['name', 'Phone', ' Photo ( URL )'];
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          cTextField.length,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SmallText(text: cTitle[index]),
              _TextFieldItem(
                  controller: cTextField[index], text: cTitle[index]),
              SizedBox(height: ThemeAppSize.kInterval12),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  const _TextFieldItem({this.text = '', required this.controller});
  @override
  Widget build(BuildContext context) {
    final style = OutlineInputBorder(
      borderSide: BorderSide(color: context.theme.hintColor),
    );
    return TextField(
      maxLines: 10,
      minLines: 1,
      controller: controller,
      cursorColor: context.theme.primaryColor,
      keyboardType: text == 'Phone' ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        hintText: controller.text,
        prefixIcon: Icon(Icons.edit, color: context.theme.hintColor),
        border: style,
        focusedBorder: style,
      ),
    );
  }
}

class _ButtonSave extends StatelessWidget {
  _ButtonSave();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            child: const MyButtonString(text: 'save'),
            onTap: () => controller.saveUpData()),
      ],
    );
  }
}

class _ButtonClose extends StatelessWidget {
  _ButtonClose();
  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(Icons.close),
      onTap: () => Get.back(),
    );
  }
}
