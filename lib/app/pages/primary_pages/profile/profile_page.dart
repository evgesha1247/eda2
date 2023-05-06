import 'package:flutter/material.dart';
import 'package:text/app/pages/primary_pages/profile/profile_body.dart';
import 'package:text/app/pages/primary_pages/profile/profile_header.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/show_dialog/custom_show_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../widgets/text/my_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        HeaderProfile(),
        BodyProfile(),
        WebViewExample(),
      ],
    );
  }
}

class WebViewExample extends StatelessWidget {
  const WebViewExample({super.key});
  @override
  Widget build(BuildContext context) {
    Widget openWeb() => Scaffold(
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse('https://vk.com/kudinov_e'))),
    );
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: InkWell(
        onTap: () => customShowDialog(widget: openWeb()),
        child: const BigText(text: 'тех. помощь'),
      ),
    );
  }
}
