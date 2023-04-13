import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text/app/pages/primary_pages/about/controller/about_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/text/my_text.dart';

import '../../../widgets/icon/wrap_icon.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _BodyTitle(title: 'Список заведений'),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _BodyAbout(),
        ],
      ),
    );
  }
}

class _BodyTitle extends StatelessWidget {
  final String title;
  const _BodyTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return BigText(text: title);
  }
}

class _BodyAbout extends StatelessWidget {
  const _BodyAbout();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    controller.initLocalData();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: GetBuilder<AboutController>(
        builder: (_) {
          return ListView.builder(
            itemCount: _.listInfoRestorans.length,
            itemBuilder: (BuildContext context, int index) => _ItemBuilder(index: index),
          );
        },
      ),
    );
  }
}

class _ItemBuilder extends StatelessWidget {
  final int index;
  const _ItemBuilder({required this.index});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutController>(
      builder: (_) {
        final rest = _.listInfoRestorans[index];
        final color = rest.status ? ThemeAppColor.kGreen : ThemeAppColor.kAccent;
        return InkWell(
          onTap: () => _.togSelectPickup(index),
          child: Container(
            decoration: BoxDecoration(
              color:
                  Colors.grey.withOpacity(_.selectedIndexPickupAdress == index ? 0.2 : 0),
              border: _.selectedIndexPickupAdress == index
                  ? Border.all(color: Colors.grey.withOpacity(0.5))
                  : null,
            ),
            child: ListTile(
              title: BigText(text: rest.adres),
              leading: WrapperIcon(
                colorBorder: color,
                child: Icon(Icons.location_on, color: color),
              ),
              subtitle: SmallText(text: rest.dataTime.values.toString()),
              trailing: SmallText(text: rest.status ? 'Открыт' : 'Закрыт', color: color),
            ),
          ),
        );
      },
    );
  }
}
