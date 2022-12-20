
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:text/app/controllers/auth_controller.dart';
import 'package:text/app/controllers/cart_controller.dart';
import 'package:text/app/pages/primary_pages/profile/profile_controller.dart';
import 'package:text/app/theme/theme_app.dart';
import 'package:text/app/widgets/button/my_button.dart';
import '../../../../utils/app_constants.dart';
import '../../../theme/theme_controller.dart';
import '../../../widgets/icon/anumated_icon_favorit.dart';
import '../../../widgets/text/my_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileUserHeader(),
        Expanded(child: _ProfileUserInfo()),
      ],
    );
    // ListView(
    //   children: const [
    //     _ProfileUserHeader(),
    //     _ProfileUserInfo(),
    //   ],
    // );
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
        cartItemsPerOrder.update(
            history[i].time!, (countItems) => ++countItems);
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
                _HistoryData(data: history[listCount].time!),
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
            )
        ],
      ),
    );
  }
}

class _HistoryData extends StatelessWidget {
  final String data;
  const _HistoryData({required this.data});
  @override
  Widget build(BuildContext context) {
    return (() {
      DateTime parseData = DateFormat("yyyy-MM-dd HH:mm:ss").parse(data);
      var inputData = DateTime.parse(parseData.toString());
      var outputFormat = DateFormat("M-d-yy, hh:mm a");
      var outputData = outputFormat.format(inputData);
      return BigText(text: outputData);
    }());
  }
}

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

////
class _ProfileUserHeader extends StatelessWidget {
  _ProfileUserHeader();
  final controller = Get.put(ProfileController());

  Future inputDialog() async {
    Map<int, String> userData = {0: 'name', 1: 'photo', 2: 'phone'};
    return showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            alignment: Alignment.bottomCenter,
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ThemeAppSize.kRadius12),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(ThemeAppSize.kInterval12),
              height: ThemeAppSize.height / 1.5,
              child: Column(
                children: [
                  GetBuilder<ThemeAppController>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SmallText(
                            text: _.isLightTheme ? 'to dark -' : 'to light -',
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: AnimatedIconWidget(
                              currIndex: (_.isLightTheme ? 0 : 1).obs,
                              fun: () => _.tooggTheme(),
                              widget1: Image(
                                color: Get.context?.theme.cardColor,
                                image: const AssetImage(
                                    "assets/icons/tog_theme.png"),
                              ),
                              widget2: Image(
                                color: Get.context?.theme.accentColor,
                                image: const AssetImage(
                                    "assets/icons/tog_theme.png"),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  const Center(child: BigText(text: 'Setting')),
                  SizedBox(height: ThemeAppSize.kInterval12),
                  Wrap(
                    children: List.generate(
                      userData.length,
                      (index) => Column(
                        children: [
                          Card(
                            color: context.theme.scaffoldBackgroundColor,
                            elevation: 3,
                            child: TextField(
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: context.theme.cardColor,
                                ),
                                isDense: true,
                                fillColor: context.theme.cardColor,
                                prefixIcon: const Icon(Icons.edit),
                                label:
                                    SmallText(text: userData[index].toString()),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(
                                  ThemeAppSize.kInterval12,
                                ),
                              ),
                              onChanged: (value) => userData[index] = value,
                            ),
                          ),
                          SizedBox(height: ThemeAppSize.kInterval12),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: const MyButtonString(text: 'save'),
                        onTap: () {
                          print(userData.values);
                        },
                      ),
                      SizedBox(width: ThemeAppSize.kInterval12),
                      InkWell(
                        child: const MyButtonString(text: 'back'),
                        onTap: () => Get.back(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    // actions: [

    // ],
  }

  Widget bgCoverImg() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          color: Colors.grey,
          child: Image.network(
            width: double.infinity,
            height: ThemeAppSize.kHeight100 * 2,
            fit: BoxFit.cover,
            'https://sun9-88.userapi.com/impg/jTS8KhO9zKlRak-GhweWQkF6ZVVEcSRiRbi7TA/Br1eQOIe7l4.jpg?size=604x340&quality=95&sign=3c6928c27d1c115a36d16b2b2a597616&type=album',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(ThemeAppSize.kInterval12),
          child: GestureDetector(
              onTap: () => inputDialog(),
              child:
                  Icon(Icons.settings, color: Get.context?.theme.primaryColor)),
        ),
      ],
    );
  }

  Widget profileImg() {
    return CircleAvatar(
      radius: ThemeAppSize.kHeight75,
      backgroundColor: Colors.grey,
      backgroundImage: const NetworkImage(
          'https://sun9-36.userapi.com/impg/clSm9XRCSftU8gXH1t0OozE7nc9tP6f6sqXr1g/PT1bLmXoTO0.jpg?size=604x604&quality=96&sign=2efc14022d3b67b00ce85ea64f7d1e70&type=album'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: ThemeAppSize.kHeight75),
          child: bgCoverImg(),
        ),
        Positioned(
          top: (ThemeAppSize.kHeight100 * 2) - ThemeAppSize.kHeight75,
          child: profileImg(),
        ),
      ],
    );
  }
}

class ProfileListTile {
  final String text;
  final IconData icon;
  final Function fun;
  const ProfileListTile({
    required this.text,
    required this.icon,
    required this.fun,
  });
}

class _ItemsListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function fun;
  const _ItemsListTile({
    required this.text,
    required this.icon,
    required this.fun,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => fun(),
          child: Card(
            elevation: 5,
            shadowColor: context.theme.cardColor,
            color: context.theme.scaffoldBackgroundColor,
            child: ListTile(
              leading: Icon(icon, color: context.theme.hintColor),
              title: BigText(text: text),
              trailing: Icon(Icons.more_vert, color: context.theme.hintColor),
            ),
          ),
        ),
        SizedBox(height: ThemeAppSize.kInterval12),
      ],
    );
  }
}

class _ProfileUserInfo extends StatelessWidget {
  _ProfileUserInfo();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final List<ProfileListTile> profileListTile = [
      ProfileListTile(
        text: 'history',
        icon: Icons.history,
        fun: controller.logoutUser,
      )
    ];

    final List<_ItemsListTile> itemsListTile = profileListTile
        .map((ProfileListTile e) => _ItemsListTile(
              text: e.text,
              icon: e.icon,
              fun: controller.logoutUser,
            ))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const BigText(text: ' #name '),
          Column(
            children: itemsListTile,
          ),
          const MyButtonString(text: 'logout')
        ],
      ),
    );
  }
}
