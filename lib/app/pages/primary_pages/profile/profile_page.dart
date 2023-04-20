import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/profile/profile_body.dart';
import 'package:text/app/pages/primary_pages/profile/profile_header.dart';
import 'package:text/app/widgets/show_dialog/custom_show_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../theme/theme_app.dart';
import '../../../widgets/text/my_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeaderProfile(),
        BodyProfile(),
        InkWell(
            onTap: () => customShowDialog(
                  widget: WebViewExample(),
                ),
            child: BigText(text: 'еслт возникли проблемы обратитесь у гуру'))

      ],
    );
  }
}

class MyButtonString extends StatelessWidget {
  const MyButtonString({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ThemeAppSize.kInterval12,
        vertical: ThemeAppSize.kInterval5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.primaryColor),
        borderRadius: BorderRadius.all(
          Radius.circular(
            ThemeAppSize.kRadius12 / 2
          ),
        ),
      ),
      child: Center(
        child: BigText(
            text: text,
            color: context.theme.primaryColor,
        ),
      ),
    );
  }
}





class WebViewExample extends StatelessWidget {
  const WebViewExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse('https://vk.com/kudinov_e'))),
    );
  }
}
