import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import '../../../../utils/app_constants.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ThemeAppSize.kInterval12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ProfileHeader(),
          SizedBox(height: ThemeAppSize.kInterval12),
          const _ProfileHistory(),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeAppController>(
      builder: (_) {
        return AnimatedIconWidget(
          currIndex: (_.isLightTheme ? 0 : 1).obs,
          fun: () => _.tooggTheme(),
          widget1: const Icon(Icons.wallet),
          widget2: const Icon(Icons.qr_code),
        );
      },
    );
  }
}

class _ProfileHistory extends StatelessWidget {
  const _ProfileHistory();
  @override
  Widget build(BuildContext context) {
    var history = Get.find<CartController>().getHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < history.length; i++) {
      if (cartItemsPerOrder.containsKey(history[i].time)) {
        cartItemsPerOrder.update(history[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(history[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeList() =>
        cartItemsPerOrder.entries.map((e) => e.value).toList();

    List<int> itemsPerOrder = cartOrderTimeList();
    var listCount = 0;


    return Expanded(
      child: ListView(

        children: [
          for (int i = 0; i < cartItemsPerOrder.length; i++)

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //     _HistoryData(data: history[listCount].time!),
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        children: List.generate(
                          itemsPerOrder[i],
                          (index) {
                            if (listCount < history.length) {

                              listCount++;
                            }
                            return index <= 2
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          ThemeAppSize.kRadius12,
                                        ),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "${AppConstansts.BASE_URL}/uploads/${history[listCount - 1].img}",
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ),
                      const Spacer(),
                      _HistoryCount(count: itemsPerOrder[i])
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// class _HistoryData extends StatelessWidget {
//   final String data;
//   const _HistoryData({required this.data});
//   @override
//   Widget build(BuildContext context) {
//     return (() {
//       DateTime parseData = DateFormat("yyyy-MM-dd HH:mm:ss").parse(data);
//       var inputData = DateTime.parse(parseData.toString());
//       var outputFormat = DateFormat("M-d-yy, hh:mm a");
//       var outputData = outputFormat.format(inputData);
//       return BigText(text: outputData);
//     }());
//   }
// }

class _HistoryCount extends StatelessWidget {
  final int count;
  const _HistoryCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BigText(
            text: '$count Items',
            size: ThemeAppSize.kFontSize20,
          ),
          SizedBox(height: ThemeAppSize.kInterval5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: context.theme.primaryColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(ThemeAppSize.kRadius12 / 1.5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ThemeAppSize.kInterval12,
                vertical: ThemeAppSize.kInterval5,
              ),
              child: SmallText(
                text: 'more',
                color: context.theme.primaryColor,
                size: ThemeAppSize.kFontSize18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
