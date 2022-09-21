import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/theme/theme_app.dart';
import 'dish_detailed_model.dart';

class DishDetailedScreen extends StatefulWidget {
  const DishDetailedScreen({Key? key}) : super(key: key);
  @override
  State<DishDetailedScreen> createState() => _DishDetailedScreenState();
}

class _DishDetailedScreenState extends State<DishDetailedScreen> {
  DishDetailedModel? _model;
  @override
  void didChangeDependencies() {
    if (_model == null) {
      final dishKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = DishDetailedModel(dishKey: dishKey);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DishDetailedModel? model = _model;
    if (model != null) {
      return ChangeNotifierProvider(
        create: (context) => model,
        child: const DishDetaild(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class DishDetaild extends StatelessWidget {
  const DishDetaild({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ThemeApp.kInterval),
          child: Column(
            children: const [
              _StackImgAndContent(),
              SizedBox(height: ThemeApp.kInterval),
              _DishDetailedDescription(),
              _MarcetWidget(),
              SizedBox(height: ThemeApp.kInterval),
              _DishDetailedButtonBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarcetWidget extends StatelessWidget {
  const _MarcetWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeApp.decoration(colors: Colors.white),
      height: 3.5,
      width: 30,
    );
  }
}

class _StackImgAndContent extends StatelessWidget {
  const _StackImgAndContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _DishDetailedContainer(),
        _DishDetailedImg(),
        _DishDetailedButtonBack(),
      ],
    );
  }
}

class _DishDetailedImg extends StatelessWidget {
  const _DishDetailedImg({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final imgUrl = model.dish?.imgUrl ?? 'assets/imgs/food2.png';
    return Align(
      child: Image.asset(imgUrl,
          height: 200,
          width: MediaQuery.of(context).size.width * 0.6,
          fit: BoxFit.contain,
          alignment: Alignment.topCenter),
    );
  }
}

class _DishDetailedContainer extends StatelessWidget {
  const _DishDetailedContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ThemeApp.decoration(),
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.all(ThemeApp.kInterval),
      child: const _DishDetailedContainerText(),
    );
  }
}

class _DishDetailedContainerText extends StatelessWidget {
  const _DishDetailedContainerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final title = model.dish?.name ?? '## название отсудствует ##';
    final price = model.dish?.price ?? 00;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _ButtBookmark(),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(title,
                    style: ThemeApp.style(size: 22, fW: FontWeight.w500))),
            Container(
              decoration: ThemeApp.decoration(colors: ThemeApp.kAccent),
              child: Padding(
                padding: const EdgeInsets.all(ThemeApp.kInterval),
                child: Text(
                  '$price\$',
                  style: ThemeApp.style(
                    size: 18,
                    fW: FontWeight.normal,
                    colors: ThemeApp.kBGColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtBookmark extends StatelessWidget {
  const _ButtBookmark({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Align(
        alignment: Alignment.topRight,
        child: Icon(
          Icons.bookmark_border,
          color: ThemeApp.kWhite,
        ),
      ),
    );
  }
}

class _DishDetailedDescription extends StatelessWidget {
  const _DishDetailedDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    final description = model.dish?.description ?? '';
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(ThemeApp.kInterval),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('description',
                  style: ThemeApp.style(size: 22, fW: FontWeight.w500)),
              const SizedBox(height: ThemeApp.kInterval),
              Text(description, style: ThemeApp.style()),
            ],
          ),
        ),
      ),
    );
  }
}

class _DishDetailedButtonBar extends StatelessWidget {
  const _DishDetailedButtonBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ThemeApp.decoration(),
      child: Padding(
        padding: const EdgeInsets.all(ThemeApp.kInterval),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.add_circle_outline,
                      size: 22,
                      color: ThemeApp.kWhite,
                    ),
                    const SizedBox(width: ThemeApp.kInterval),
                    Text('1', style: ThemeApp.style()),
                    const SizedBox(width: ThemeApp.kInterval),
                    const Icon(Icons.remove_circle_outline,
                        size: 22, color: ThemeApp.kWhite)
                  ],
                ),
                Row(children: [Text('total : 200\$ ', style: ThemeApp.style())])
              ],
            ),
            const SizedBox(height: ThemeApp.kInterval),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: ThemeApp.decoration(colors: ThemeApp.kAccent),
                child: Center(
                  child: Text(
                    'add to cart',
                    style: ThemeApp.style(
                      colors: ThemeApp.kFrontColor,
                      fW: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DishDetailedButtonBack extends StatelessWidget {
  const _DishDetailedButtonBack({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DishDetailedModel>();
    return GestureDetector(
      onTap: () => model.showMenu(context),
      child: Container(
        decoration: ThemeApp.decoration(),
        padding: const EdgeInsets.only(
          top: ThemeApp.kInterval,
          bottom: ThemeApp.kInterval,
          left: ThemeApp.kInterval + 10,
          right: ThemeApp.kInterval,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: ThemeApp.kAccent,
        ),
      ),
    );
  }
}
